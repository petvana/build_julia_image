# build_julia_image

First, run the following. It will take a while (2 mins) + several GB of RAM.
```bash
julia build_image.jl 
```

Then, the system image (`user_image.so`) is prepared for you, and can be run by
```bash
julia -J user_image.so
```

I preffer to create short bash script of selected name (I use only `j`)
```bash
#!/usr/bin/env bash
julia -J /[YOUR-PATH]/build_julia_image/user_image.so $@
```
