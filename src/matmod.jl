module matmod
    using Plots, DifferentialEquations, ProgressMeter

    f(u,p,t) = 1.01*u
    u0=1/2
    tspan = (0.0,1.0)
    prob = ODEProblem(f,u0,tspan)
    solution = solve(prob,Tsit5(),reltol=1e-2,abstol=1e-2)

    plot(sol)

    mutable struct Glacier
        t
        h
        u
        v
    end

    function step!(g::Glacier)

    end

    g = Glacier()

    @showprogress for i in 1:steps
        step!(g)
    end
end # module
