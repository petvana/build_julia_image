@eval Module() begin

autocompiler_dir = "$(homedir())/.julia/autocompiler/v$(VERSION.major).$(VERSION.minor)"

mkpath(autocompiler_dir)

PrecompileStagingArea = Module()
for (_pkgid, _mod) in Base.loaded_modules
    if !(_pkgid.name in ("Main", "Core", "Base"))
        eval(PrecompileStagingArea, :(const $(Symbol(_mod)) = $_mod))
    end
end

let 
    status_true = 0
    status_false = 0
    status_fail = 0
    statement_file = "$(autocompiler_dir)/statements.txt"
    if isfile(statement_file)
        for statement in eachline(statement_file)
            # println(statement)
            # The compiler has problem caching signatures with `Vararg{?, N}`. Replacing
            # N with a large number seems to work around it.
            statement = replace(statement, r"Vararg{(.*?), N} where N" => s"Vararg{\\1, 100}")
            try
                statement = "tmp = " * statement
                Base.include_string(PrecompileStagingArea, statement)
                if PrecompileStagingArea.tmp
                    status_true += 1
                else
                    status_false += 1
                end
            catch
                status_fail += 1
                # See julia issue #28808
                @debug "failed to execute \$statement"
            end
            print("\r Compilation (")
            printstyled(status_true, color = status_true > 0 ? :green : :normal )
            print(",")
            printstyled(status_false, color = status_false > 0 ? :yellow : :normal )
            print(",")
            printstyled(status_fail, color = status_fail > 0 ? :red : :normal )
            print(")     ")
        end
    else
        @warn "There is no statement file: $statement_file"
    end
end
println()

end # module
