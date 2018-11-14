function [A, B, C, total] = areas(xs, xf, q0, r)
A = q0*xs;
  xt = xs + q0/r;
B = (xt-xs)*q0/2;
C = r/2*(xf-xt)^2;

total = A+B-C; %skal bli 0
end