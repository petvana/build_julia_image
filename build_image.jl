using Pkg
Pkg.update()

using PackageCompiler

create_sysimage(
    [:PyPlot, :JuMP], # , :PyPlot 
    sysimage_path="user_image.so", 
    precompile_execution_file="precompiled.jl"
)
