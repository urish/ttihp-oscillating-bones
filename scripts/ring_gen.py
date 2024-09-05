# SPDX-License-Identifier: Apache-2.0
# Author: Uri Shaked

import math

RADIUS = 6000
STAGES = 21

lines = [
    "magic",
    "tech sky130A",
    "timestamp 1712735402",
]

lines += [
    f"<< metal2 >>",
]


def circle(cx, cy, r, thickness=10, steps=360):
    for i in range(steps):
        x = cx + r * math.cos(2 * math.pi * i / steps)
        y = cy + r * math.sin(2 * math.pi * i / steps)
        lines.append(
            f"rect {int(x-thickness/2)} {int(y-thickness/2)} {int(x+thickness/2)} {int(y+thickness/2)}"
        )


circle(0, 0, 4900, 200, 360)
circle(0, 0, 7200, 200, 500)

for i in range(STAGES):
    x = int(RADIUS * math.cos(2 * math.pi * i / STAGES)) - 500
    y = int(RADIUS * math.sin(2 * math.pi * i / STAGES)) - 700
    lines += [
        f"use skullfet_inverter  skullfet_inverter_{i}",
        "timestamp 1712756528",
        f"transform 1 0 {x} 0 1 {y}",
        "box 410 120 1900 2780",
    ]

lines += ["<< end >>"]

with open("../mag/ring.mag", "w") as f:
    f.write("\n".join(lines))
