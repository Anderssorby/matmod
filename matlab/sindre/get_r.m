function [r, a, b] = get_r(xs, xf, q0, h0)
a = 1/2*(xf^2+xs^2)-xs*xf;
b = q0*(xs-xf)-q0*xs+h0;
r = -(b/a);
end