function [res] = h_func(x, xs, xf, q0, h0, r, lambda, m)
C = lambda*h0^(m+2);
if (x >= 0 && x < xs)
    res = q0*x + C;
elseif (x >= xs && x <= xf)
    res = q0*x - r/2*(x -xs)^2 + C;
else
    res = 0;
end
res = (1/lambda*res)^(1/(m+2));

end