#=
upwind:
- Julia version: Unknown
- Author: anderscs
- Date: 2018-11-07
=#
using DifferentialEquations, Plots

# du/dt + a du/dx = f(x)
U = 0
meshgrid(x, y) = (repeat(x, outer=length(y)), repeat(y, inner=length(x)))

function upwind(f, initial_f, x, z, constant)
    ## Build the mesh
    T = (0.0,30.0)
    Tsteps = 10
    N = 100
    delta_x = Δx = 1//
    delta_t = Δt = 1//2^(2)
    fem_mesh = hyperbolic_sqaremesh([], delta_t)
    U = zeros(Tsteps, N)
    U[0,:] = initial_f.(U[0,:])

    for n in range(0,Tsteps) # Timestep
         # space
         U[ n+1, i] = f.(x) + (1/delta_t + constant/delta_x)U[n,i] - constant/delta_x*U[n,i]
    end

# fem_mesh = parabolic_squaremesh([0 1 0 1],Δx,Δt,T,:neumann)
# u0 = initial_f.(fem_mesh.node)

## Build the problem type

# prob = HeatProblem(u0,f,fem_mesh,D=[.003 .001])

## Solve
# sol = solve(prob, alg=FEMDiffEqHeatImplicitEuler(), save_everystep=true, timeseries_steps=1)
# animate(sol, "../assets/diffconsts.gif", zlim=(-0.01,.01), cbar=false)
end
