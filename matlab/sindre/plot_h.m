function [h_max, h_vec] = plot_h(xs, xf, q0, h0, r, lambda, m, nx)
x = linspace(0, 1.1*xf, nx);
h_vec = zeros(1, length(x));
for i = 1:length(x)
    h_vec(i) = h_func(x(i), xs, xf, q0, h0, r, lambda, m);
end
h_max = max(h_vec);
plot(x, h_vec)
ylim([0.9*min(h_vec),1.1*max(h_vec)])
end