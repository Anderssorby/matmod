function [res] = q_func(x, xs, xf, q0, r)
if (x >= 0 && x < xs)
    res = q0;
elseif (x >= xs && x <= xf)
    res = q0 - r*(x-xs);
else
    res = 0;
end
end