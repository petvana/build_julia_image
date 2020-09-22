using Pkg
Pkg.update()

Pkg.add("PackageCompiler")
using PackageCompiler

# There is still problem with PyPlot, see https://github.com/JuliaPy/PyPlot.jl/issues/476
pyplot_subpackages = [:Colors, :LaTeXStrings, :PyCall, :Sockets, :Test, :VersionParsing]

Pkg.add.(string(x) for x in pyplot_subpackages)

create_sysimage(
    [:JuMP, :Ipopt, pyplot_subpackages...], 
    sysimage_path="user_image.so", 
    precompile_execution_file="precompiled.jl",
    # incremental = false
)
