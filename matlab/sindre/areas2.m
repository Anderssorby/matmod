function [A, B, C, total] = areas2(xs, xf, q0, r, h0)
A = q0*xs;
  xt = xs + q0/r;
B =(xt-xs)*q0/2;
C = r/2*(xf-xt)^2;
total = A+B-C-h0;

end