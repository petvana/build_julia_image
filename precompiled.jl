# using Plots

# p = Plots.plot(rand(5), rand(5))
# display(p)

# using PyPlot
# plt.plot(1,1,"rx")

################################################################################
module BuildIpopt

using JuMP
using Ipopt

model = Model(Ipopt.Optimizer)
@variable(model, -10 <= x <= 3, start = 0.0)
@variable(model, y, start = 13.0)

@NLobjective(model, Min, (1 - x)^2 + 100 * (y - x^2)^2)

optimize!(model)
println("x = ", value(x), " y = ", value(y))

# adding a (linear) constraint
@constraint(model, x + y == 10)
optimize!(model)
println("x = ", value(x), " y = ", value(y))

end