function plot_q(xs, xf, q0, r)
x = linspace(0, 1.1*xf);
q_vec = zeros(1, length(x));
for i = 1:length(x)
    q_vec(i) = q_func(x(i), xs, xf, q0, r);
end

plot(x, q_vec, x, zeros(1,length(x)),':')
ylim([1.1*min(q_vec),1.1*q0])
end