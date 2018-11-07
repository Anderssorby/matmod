%%% ANDERS HJORT
%%% Attempt on solving h_t + lambda*(d/dx)h^(m+2) = q(x) via upwind scheme

function mtx = upwind()
%% SETTINGS
N = 100; % Number of points in grid
x_start = 0;
x_end = 1;
x_grid = linspace(x_start, x_end, N);
dx = (x_end-x_start)/N;

M = 100; % Number of time steps
t_start = 0;
dt = 0.1;

lambda = 1; %according to Hedda, need to check this


%% Initialize glacier and source q(x)
qq = zeros(1,N);

q0 = 1;
slope = -1;
b = q0-slope*(x_end/2); %calculate intersetc s.t. y(x) = slope*x+b = q0 at xs
q = @(x) b+slope*x;
for i=1:N
    x = x_start+dx*i;
     if(x < x_end/2)
            qq(1,i) = q0;
        elseif x > x_end
            qq(1,i) = 0;
        else
            qq(1,i) = q(x);
     end
end


h = zeros(M,N);
h0 = @(x) min(0.1, 10-0.1*x)
h(1,1:N) = feval(h0,x_grid); 

for j=1:(M-1) %time
    for i=2:N %space
        x = x_start+dx*i;
        h(j+1,i) = h(j,i) + qq(i)*dt+lambda*(dx/dt)*(h(j,i-1)-h(j,i));
    end
end

%% PLOTTING

subplot(3,1,1)
plot(x_grid, qq)
title('Source function q(x)')
axis([x_start x_end*1.1 -2 2]);

subplot(3,1,2)
plot(x_grid, h(1,1:N))
title('Starting glacier h(x,t=0)')
axis([x_start x_end*1.1 0 3]);

for i=1:M
    subplot(3,1,3)
    plot(x_grid, h(i,1:N));
    axis([x_start x_end*1.5 0 3]);
    title(['time = ', num2str(i), ' of ', num2str(M)]) 
    pause(0.2);
end

mtx = h;
end 

