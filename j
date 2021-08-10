#!/usr/bin/env bash

bin=julia

version=`$bin -v`
version=($version)
version=${version[2]}
version=v"${version:0:3}"

autocompiler_dir=~/.julia/autocompiler/$version

tmp1=`mktemp`
global_statements=$autocompiler_dir/statements.txt 

$bin -J $autocompiler_dir/image.so -L ~/.julia/config/startup-autocompiler.jl --trace-compile $tmp1 "$@"

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



