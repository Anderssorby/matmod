function q_source = getSource(x_grid)
N = length(x_grid);
x_start = x_grid(1);
x_end = x_grid(N);
dx = (x_end-x_start)/N;

q = zeros(1,N);
q0 = 1;
qend = -1; 
xs = x_end/2;
slope = (q0-qend)/(xs-x_end);
b = qend-slope*x_end; %calculate intersect s.t. y(x) = slope*x+b = q0 at xs
qqq = @(x) b+slope*x;

for i=1:N
    x = x_start+dx*i;   
     if(x < xs)
            q(1,i) = q0;
        elseif x > x_end
            q(1,i) = 0;
        else
            q(1,i) = qqq(x);
     end
end
q_source = q;

end
