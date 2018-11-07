
using Plots, DifferentialEquations, ProgressMeter

H = 10.0
Q = 5.0
theta = 12.0
m = 3.0
μ = mu = 1.0
ε = epsilon = 1.0
κ = kappa = 2*mu*epsilon*H*Q*theta^(m)
λ = lambda = - kappa/(m+2)
q0 = 1.0
x_s = 5.0
x_f = 10.0
max_h = 20
r=0.5
stat_h(x) = (1/lambda*(2*q0*x - r*(x_s*x - 0.5*x^2)))^(m+2)
d_xh(x) =  ((m+2)/lambda*(2*q0*x - r*(x_s*x - 0.5*x^2)))^(m+1)*(2*q0 - r*(x_s-x))

meshgrid(x, y) = (repeat(x, outer=length(y)), repeat(y, inner=length(x)))


function plot_steady_state()
    #x = range(0,x_f, length = 100)
    x, z = meshgrid(0:0.5:x_f, 0:0.5:max_h)

    h = stat_h.(x)
    plot(x, h)
    savefig("steady_state.pdf")


    u(x,z,t) = @. -kappa/(m+1)*((h-z)^(m+1) - h^(m+1))
    C_v = 0
    v(x,z,t) = @. -kappa*(1/(m+1)*(h-z)^(m+1) + h^(m)*z)*d_xh(x) + C_v
    t = 0
    vr = v(x,z,t)
    ur = u(x,z,t)

    quiver(x,z, quiver=(vr, ur))
    savefig("steady_flow_field.pdf")
end

# Statinary problem
function q(x)
    if x < x_s
        return q0
    elseif x < x_f
        return q0 + r*(x_s-x)
    else
       return 0
    end
end
f(h, p, x) = (1/lambda * q(x))^(m+1)
f0=1/2
xspan = (0.0,10.0)


function solve_ode()
prob = ODEProblem(q,f0,xspan)

  solution = solve(prob,Tsit5(),reltol=1e-2,abstol=1e-2)

  print(solution)

  plot(solution)
  gui()
  savefig("plot.pdf")
end


mutable struct Glacier

t
x
  h
end


# h_t + \labmda (m+1)h^(m+1) dh/dx = q(x)

function step!(g::Glacier)
  # Gudnov's scheme


  C_v = 0
  # Flow field
  u(x,z,t) = -kappa/(m+1)*((h-z)^(m+1) - h^(m+1))
  v(x,z,t) = -kappa*(1/(m+1)*(h-z)^(m+1) + h^(m)*z)*d_xh + C_v
end

g = Glacier(1, 1, 0)
steps = 100

#@showprogress for i in 1:steps
#  step!(g)
#  println("step")
#end
# module
