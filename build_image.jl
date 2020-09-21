using Pkg
Pkg.update()

Pkg.add("PackageCompiler")
using PackageCompiler

create_sysimage(
    [:JuMP, :Ipopt], # , :PyPlot 
    sysimage_path="user_image.so", 
    precompile_execution_file="precompiled.jl"
)
