# SPDX-License-Identifier: Apache-2.0
# Author: Uri Shaked

import math

RADIUS = 5200
STAGES = 21

HFLIP_STAGES = [1, 12, 13, 14, 15, 16, 17, 18, 19]
VFLIP_STAGES = [13, 14, 15, 16, 17, 18, 19, 20]
ADJUSTMENTS = {
    0: [200, -300],
    1: [300, -140],
    9: [0, 200],
    11: [-400, -100],
    12: [0, -200],
    19: [0, -400],
    20: [0, -500],
}

lines = [
    "magic",
    "tech sky130A",
    "magscale 1 2",
    "timestamp 1712735402",
]

metal1 = [
    f"<< metal1 >>",
]

metal2 = [
    f"<< metal2 >>",
]

instances = []


def rect(x1, y1, x2, y2):
    xmin = min(x1, x2)
    xmax = max(x1, x2)
    ymin = min(y1, y2)
    ymax = max(y1, y2)
    return f"rect {scale(xmin)} {scale(ymin)} {scale(xmax)} {scale(ymax)}"


def circle(cx, cy, r, thickness=10, steps=360):
    for i in range(steps):
        x = cx + r * math.cos(2 * math.pi * i / steps)
        y = cy + r * math.sin(2 * math.pi * i / steps)
        metal2.append(
            rect(
                x - thickness / 2,
                y - thickness / 2,
                x + thickness / 2,
                y + thickness / 2,
            )
        )


def scale(coord: int) -> int:
    """Scale a coordinate to match the magic scale factor"""
    return int(coord * 2)


circle(0, 0, 4200, 200, 360)
circle(0, 0, 6336, 200, 500)


for i in range(STAGES):
    xsign = -1 if i in HFLIP_STAGES else 1
    ysign = -1 if i in VFLIP_STAGES else 1
    x = int(RADIUS * math.cos(2 * math.pi * i / STAGES)) - 500 * xsign
    y = int(RADIUS * math.sin(2 * math.pi * i / STAGES)) - 700 * ysign
    if i in ADJUSTMENTS:
        x += ADJUSTMENTS[i][0]
        y += ADJUSTMENTS[i][1]

    # Create metal stubs for routing
    stub_x = x + xsign * 277
    sig_y = y + 800 * ysign
    sig_x_right = stub_x + 717 * xsign
    metal2 += [
        # Power ports
        rect(stub_x, y, stub_x + 45 * xsign, y + 100 * ysign),
        rect(stub_x, y + 1500 * ysign, stub_x + 45 * xsign, y + (1500 + 100) * ysign),
    ]
    metal1 += [
        # Signal ports
        rect(stub_x, sig_y, stub_x - 100 * xsign, sig_y + 50 * ysign),
        rect(sig_x_right, sig_y, sig_x_right + 100 * xsign, sig_y + 50 * ysign),
    ]

    transform = f"transform {xsign} 0 {scale(x)} 0 {ysign} {scale(y)}"

    # Create the inverter instances
    instances += [
        f"use skullfet_inverter_5v  skullfet_inverter_{i}",
        "timestamp 1735290363",
        transform,
        "box 454 132 2110 3088",
    ]

lines += metal1
lines += metal2
lines += instances
lines += ["<< end >>"]

with open("../mag/ring.mag", "w") as f:
    f.write("\n".join(lines) + "\n")
