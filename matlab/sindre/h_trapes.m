function [h] = h_trapes(q, xvec, xt, h0, lambda, m)

n = length(xvec);
h = zeros(1, n);
h(1) = h0;
for i = 2:n
    h(i) = h(i-1) + 1/lambda*(0.5*(xvec(i)-xvec(i-1))*(q(xvec(i))+q(xvec(i-1))))^(1/(m+2));
end

end