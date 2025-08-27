# SPDX-License-Identifier: Apache-2.0
# Author: Uri Shaked

import math
import gdstk
import os.path

GDS_PATH = os.path.join(os.path.dirname(__file__), "../gds")
GDS_FILE = os.path.join(GDS_PATH, "ring.gds")

RADIUS = 52.00
STAGES = 21

HFLIP_STAGES = [1, 12, 13, 14, 15, 16, 17, 18, 19]
VFLIP_STAGES = [13, 14, 15, 16, 17, 18, 19, 20]
ADJUSTMENTS = {
    0: [2.00, -3.00],
    1: [3.00, -1.40],
    9: [0, 2.00],
    11: [-4.00, -1.00],
    12: [0, -2.00],
    19: [0, -4.00],
    20: [0, -5.00],
}

LAYERS = {
    "metal2.drawing": {"layer": 10, "datatype": 0},
    "metal3.drawing": {"layer": 30, "datatype": 0},
}


def circle(cx, cy, r, thickness=10, steps=360):
    rects = []
    for i in range(steps):
        x = cx + r * math.cos(2 * math.pi * i / steps)
        y = cy + r * math.sin(2 * math.pi * i / steps)
        rects.append(
            gdstk.rectangle(
                (x - thickness / 2, y - thickness / 2),
                (x + thickness / 2, y + thickness / 2),
                **LAYERS["metal3.drawing"]
            )
        )
    return rects


def load_skullfet_inverter():
    gds = gdstk.read_gds(os.path.join(GDS_PATH, "skullfet_inverter.gds"))
    return gds.top_level()[0]


def generate_ring(skullfet_inverter):
    cell = gdstk.Cell("ring")
    # Ring boundaries
    cell.add(*circle(0, 0, 42.00, 2.00, 360))
    cell.add(*circle(0, 0, 63.36, 2.00, 500))

    # Ring'o'skulls
    for i in range(STAGES):
        xsign = -1 if i in HFLIP_STAGES else 1
        ysign = -1 if i in VFLIP_STAGES else 1
        x = int(RADIUS * math.cos(2 * math.pi * i / STAGES)) - 5.00 * xsign
        y = int(RADIUS * math.sin(2 * math.pi * i / STAGES)) - 7.00 * ysign
        if i in ADJUSTMENTS:
            x += ADJUSTMENTS[i][0]
            y += ADJUSTMENTS[i][1]

        # Create metal stubs for routing
        stub_x = x + xsign * 2.77
        sig_y = y + 8.00 * ysign
        sig_x_right = stub_x + 7.17 * xsign

        # Power ports
        cell.add(
            gdstk.rectangle(
                (stub_x, y),
                (stub_x + 0.45 * xsign, y + 1.00 * ysign),
                **LAYERS["metal3.drawing"]
            )
        )
        cell.add(
            gdstk.rectangle(
                (stub_x, y + 15.00 * ysign),
                (stub_x + 0.45 * xsign, y + (15.00 + 1.00) * ysign),
                **LAYERS["metal3.drawing"]
            )
        )

        # Signal ports
        cell.add(
            gdstk.rectangle(
                (stub_x, sig_y),
                (stub_x - 1.00 * xsign, sig_y + 0.50 * ysign),
                **LAYERS["metal2.drawing"]
            )
        )
        cell.add(
            gdstk.rectangle(
                (sig_x_right, sig_y),
                (sig_x_right + 1.00 * xsign, sig_y + 0.50 * ysign),
                **LAYERS["metal2.drawing"]
            )
        )

        # Add the inverter instance
        x_reflect = xsign == -1
        rotation = 0
        if ysign == -1:
            rotation = math.pi
            x_reflect = False
        #if xsign != ysign:
        #   rotation = math.pi/2
        cell.add(
            gdstk.Reference(
                skullfet_inverter, (x, y), x_reflection=x_reflect, rotation=rotation
            )
        )

    return cell


if __name__ == "__main__":
    lib = gdstk.Library()
    skullfet_inverter = load_skullfet_inverter()
    lib.add(skullfet_inverter)
    lib.add(generate_ring(skullfet_inverter))
    lib.write_gds(GDS_FILE)
