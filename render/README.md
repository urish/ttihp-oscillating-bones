# 3D Render of Oscillating Bones

Creates a 3D render of the GDS file of the Oscillating Bones project, using the Mitsuba renderer.

The code is based on [Maximo Balestrini](https://github.com/mbalestrini)'s [GDS2Obj project](https://github.com/mbalestrini/GDS2Obj) and his prelinimary work on 3D rendering of Tiny Tapeout projects.

## How to use

```sh
pip install -r requirements.txt
make
```

If your system does not have CUDA, you can use the CPU renderer by running:

```sh
make variant=llvm_ad_rgb
```

This will create a file called `oscillating_bones_2048.png` with the 3D render of the project.

Rendering the final image can take a while. You can speed up the process by reducing the number of samples per pixel. For example, to render a quick preview, you can run:

```sh
make SAMPLES_PER_PIXEL=16
```

When the render is complete, you can view the image by opening the `oscillating_bones_16.png` file.
