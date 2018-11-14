function [res] = v_func(x, z, h, h_der, d, d_der, kappa, m)
c   = kappa*(  h_der(x)/(m+1) * (h(x)-d)^(m+1) + d*(h_der(x)-d_der)*(h(x)-d)^(m));
res = kappa*( -h_der(x)/(m+1) * (h(x)-z)^(m+1) - z*(h_der(x)-d_der)*(h(x)-d)^(m) ) + c;
end
