#!/usr/bin/env bash

# This is faster than `julia -e "print(VERSION)"`
version=`julia -v`
version=($version)
version=${version[2]}
version=v"${version:0:3}"

autocompiler_dir=~/.julia/autocompiler

tmp1=`mktemp`
global_statements=$autocompiler_dir/statements.txt 

# There is still problem with PyPlot, see https://github.com/JuliaPy/PyPlot.jl/issues/476
# That is why we use startup.jl file when running user image.
julia -J $autocompiler_dir/$version/image.so -L $autocompiler_dir/startup.jl --trace-compile $tmp1 "$@"

echo STATEMENTS -----
wc -l $tmp1

cat $global_statements >> $tmp1
#wc -l $tmp1
cat $global_statements >> $tmp1
#wc -l $tmp1

echo Global statements -----
wc -l $global_statements
sort $tmp1 | uniq -u >> $global_statements
wc -l $global_statements



