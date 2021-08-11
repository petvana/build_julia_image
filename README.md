# build_julia_image

First, select libraries to be included in `build_image.jl` file.
Secondly, run the following. It will take a while (2 mins) + several GBs of RAM.
```bash
julia build_image.jl 
```

Then, the system image (`user_image.so`) is prepared for you in `~/.julia/autocompiler/vX.X/` directory.

Now you can run Julia simply by `j` script, and all libraries should be already pre-loaded. You may also add `j` into the system path.
```bash
./j
```