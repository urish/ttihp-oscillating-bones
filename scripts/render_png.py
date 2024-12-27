# SPDX-License-Identifier: Apache-2.0
# This script creates a full-die render of a given Tiny Tapeout shuttle.
# Copyright (C) 2024 Tiny Tapeout LTD
# Author: Uri Shaked

import argparse
import logging
import os
from PIL import Image

from klayout.lay import LayoutView

PDK_ROOT = os.environ.get("PDK_ROOT")
PDK = os.environ.get("PDK", "sky130A")


def render_gds(
    gds_path: str,
    output_path: str,
    scale: float = 1.0,
):
    BOUNDARY_LAYER = "prBoundary.boundary"

    lv = LayoutView()
    lv.load_layout(gds_path)
    lv.max_hier()
    lv.load_layer_props(f"{PDK_ROOT}/{PDK}/libs.tech/klayout/tech/{PDK}.lyp")
    lv.set_config("background-color", "#ffffff")
    lv.set_config("grid-visible", "false")
    lv.set_config("text-visible", "false")

    lv.zoom_fit()

    bbox = None
    for layer in lv.each_layer():
        layer_name = layer.name.split("-")[0].strip() if "-" in layer.name else ""
        # Remove ditheering from metal2, for better looking artwork
        if layer_name == "met2.drawing":
            layer.dither_pattern = 0
        if layer_name == BOUNDARY_LAYER:
            bbox = layer.bbox()
            layer.visible = True

    if bbox is None:
        raise ValueError(f"No bounding box found for '{BOUNDARY_LAYER}' layer")

    lv.zoom_box(bbox)

    lv.save_image(output_path, int(bbox.width() * scale), int(bbox.height() * scale))
    lv.destroy()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Render layout screen shot")
    parser.add_argument(
        "--scale",
        type=float,
        default=10,
        help="Scale factor for the output image",
    )

    args = parser.parse_args()
    logging.basicConfig(level=logging.INFO)
    script_dir = os.path.dirname(os.path.abspath(__file__))
    gds_path = os.path.join(script_dir, "../gds/tt_um_oscillating_bones.gds")
    output_path = os.path.join(script_dir, "../docs/layout.png")

    render_gds(
        gds_path,
        output_path,
        scale=args.scale,
    )

    # Use PIL to rotate the image 90 degrees
    image = Image.open(output_path)
    image.save(output_path)
