import mitsuba as mi
import argparse
from datetime import datetime
import time

RENDER_WIDTH = 1920
RENDER_HEIGHT = 1080
# Samples per pixel:
RENDER_SPP = 256
VARIANT = "cuda_ad_rgb"
OUTPUT_NAME = f"scene_tinytapeout_{datetime.now().strftime('%Y%m%d_%H%M%S')}.png"
SENSOR_INDEX = 0

argparser = argparse.ArgumentParser(description="Render scene_tinytapeout.xml")
argparser.add_argument(
    "-width", "--output_width", required=False, type=int, help="Output resolution width"
)
argparser.add_argument(
    "-height",
    "--output_height",
    required=False,
    type=int,
    help="Output resolution height",
)
argparser.add_argument(
    "-spp",
    "--samples_per_pixel",
    required=False,
    type=int,
    help="Render samples per pixel",
)
argparser.add_argument(
    "-v",
    "--variant",
    required=False,
    type=str,
    choices=["scalar_rgb", "cuda_ad_rgb", "llvm_ad_rgb", "scalar_spectral"],
    help="Mitsuba2 variant",
)
argparser.add_argument(
    "-o",
    "--output",
    required=False,
    type=str,
    help="Output filename",
)
args = vars(argparser.parse_args())

if args["output_width"] != None:
    RENDER_WIDTH = args["output_width"]
if args["output_height"] != None:
    RENDER_HEIGHT = args["output_height"]
if args["samples_per_pixel"] != None:
    RENDER_SPP = args["samples_per_pixel"]
if args["variant"] != None:
    VARIANT = args["variant"]
if args["output"] != None:
    OUTPUT_NAME = args["output"]

mi.set_variant(VARIANT)

scene = mi.load_file("scene_tinytapeout.xml")

print(
    f"Rendering {RENDER_WIDTH}x{RENDER_HEIGHT} image with {RENDER_SPP} samples per pixel"
)
print(f"Variant: {mi.variant()}")
sensor = scene.sensors()[SENSOR_INDEX]
params = mi.traverse(sensor)
params["film.size"] = mi.ScalarVector2u(RENDER_WIDTH, RENDER_HEIGHT)
params.update()
process_start_time = time.time()
img = mi.render(scene, spp=RENDER_SPP, sensor=SENSOR_INDEX)
mi.util.write_bitmap(OUTPUT_NAME, img, False)
print(f"Wrote image to {OUTPUT_NAME}")
print(f"Elapsed time: { (time.time()-process_start_time)}")
