#!/usr/bin/env python3

import argparse
import sys

import gdstk


def main(input_gds: str, output_gds: str):
    lib_main = gdstk.read_gds(input_gds)
    for cell in lib_main.top_level():
        # Remove Klayout PCell info:
        if cell.name == "$$$CONTEXT_INFO$$$":
            lib_main.remove(cell)
    lib_main.write_gds(output_gds)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("gds_in", help="Input GDS file")
    parser.add_argument("gds_out", help="Output GDS file")
    args = parser.parse_args(sys.argv[1:])
    main(args.gds_in, args.gds_out)
