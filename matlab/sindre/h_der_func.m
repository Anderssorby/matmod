function [res] = h_der_func(x, xs, xf, q0, h0, r, lambda, m)
C = lambda*h0^(m+2);
if (x >= 0 && x < xs)
    res = q0/((m+2)*lambda)*(q0*x + C)^(1/(m+2)-1);
elseif (x >= xs && x <= xf)
    res = (q0 - r*(x-xs))/((m+2)*lambda)*(q0*x - r/2*(x -xs)^2 + C)^(1/(m+2)-1);
else
    res = 0;
end

end