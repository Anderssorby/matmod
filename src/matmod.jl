module matmod
using Plots, DifferentialEquations, ProgressMeter

q0 = 1.0
x_s = 5.0
r=0.5
q(u,p,x) = q0 + r*(x_s-x)
u0=1/2
xspan = (0.0,10.0)
prob = ODEProblem(q,u0,xspan)
solution = solve(prob,Tsit5(),reltol=1e-2,abstol=1e-2)

print(solution)

plot(solution)
gui()

mutable struct Glacier
  t
  h
  u
  v
end

function step!(g::Glacier)

end

# g = Glacier()
steps = 100

@showprogress for i in 1:steps
  # step!(nothing)
  print("step")
end
end # module
