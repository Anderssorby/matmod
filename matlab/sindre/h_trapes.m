function [q_area] = h_trapes(q, xvec, xt, h0, lambda, m)

n = length(xvec);
q_area = zeros(1, n);
q_area(1) = (1/lambda*h0)^(1/(m+2));
for i = 2:n
    q_area(i) = q_area(i-1) + (1/2*(xvec(i)-xvec(i-1))*(q(xvec(i))+q(xvec(i-1))));
end
h = lambda*q_area.^(m+2);
end