#!/usr/bin/env julia

using Pkg
using Logging
# Pkg.update()

# Pkg.add("PackageCompiler")
using PackageCompiler

logger = SimpleLogger(stderr, Logging.Debug)
global_logger(logger)

packages = [
    :JuMP,
    :Ipopt,
    :Dubins,
    :TimerOutputs,
    :PyPlot,
    :ProgressMeter,
    # :AutoCompiler,
]

# There is still problem with PyPlot, see https://github.com/JuliaPy/PyPlot.jl/issues/476

autocompiler_dir = "$(homedir())/.julia/autocompiler/v$(VERSION.major).$(VERSION.minor)"
# statements_dir = "$(autocompiler_dir)/statements"
# statement_files = readdir(statements_dir, join=true)

create_sysimage(
    packages,
    sysimage_path="$(autocompiler_dir)/image.so", 
    script = "precompile_snooped.jl",
    # incremental = false
)
