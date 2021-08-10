#!/usr/bin/env julia

using Pkg
Pkg.update()
using Logging

Pkg.add("PackageCompiler")
using PackageCompiler

# If you want to debug the compilation, use the following code:
# logger = SimpleLogger(stderr, Logging.Debug)
# global_logger(logger)

packages = [
    :JuMP,
    :Ipopt,
    :Dubins,
    :TimerOutputs,
    :PyPlot,
    :ProgressMeter,
]

autocompiler_dir = "$(homedir())/.julia/autocompiler"
autocompiler_dir_version = "$(autocompiler_dir)/v$(VERSION.major).$(VERSION.minor)"
mkpath(autocompiler_dir_version)
cp("startup.jl",  "$(autocompiler_dir)/startup.jl", force=true)

create_sysimage(
    packages,
    sysimage_path="$(autocompiler_dir_version)/image.so",
    script = "precompile_snooped.jl",
    # incremental = false
)
