using DifferentialEquations, Plots
f = (t,x,u)  -> [zeros(size(x,1))    zeros(size(x,1))]
u0_func = (x) -> [float.((abs.(x[:,1]-.5) .< 1e-6) .& (abs.(x[:,2]-.5) .< 1e-6)) float.((abs.(x[:,1]-.5) .< 1e-6) .& (abs.(x[:,2]-.5) .< 1e-6))]  # size (x,2), 2 meaning 2 variables


