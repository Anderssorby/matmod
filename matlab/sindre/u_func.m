function [res] = u_func(x, z, h, d, kappa, m)
res = -(kappa/(m+1))*((h(x) - z)^(m+1)-(h(x) - d)^(m+1));
end