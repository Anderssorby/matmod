function q_source = getSource(x_grid, xf, sourceChoice)
N = length(x_grid);
x_start = x_grid(1);
x_end = x_grid(N);
dx = (x_end-x_start)/N;

q = zeros(1,N);

if sourceChoice == 1 %Piecewise linear option
    q0 = 1;
    xs = xf/7;
    %r = -2;
    r = -2*q0*xf/(xf-xs)^2;
    qqq = @(x) q0 - r*(xs-x);

    for i=1:N
        x = x_start+dx*i;   
         if(x < xs)
           q(1,i) = q0;
        elseif x <= xf
               q(1,i) = qqq(x);
        else
               q(1,i) = 0;
        end
    end
elseif sourceChoice == 2 %exponential option
    q0 = 4;
    q_min = 2;
    r =1;
    qqq = @(x) (-q0)*exp(r*(x-x_end/2))/(1+exp(r*(x-x_end/2)))+q_min;
    for i =1:N
        x = x_start+dx*i; 
        q(1,i) = qqq(x);
    end
end


q_source = q;

end
