%%% ANDERS HJORT
%%% Attempt on solving h_t + lambda*(d/dx)h^(m+2) = q(x) via upwind scheme

function mtx = upwind()
%% SETTINGS
N = 1000; % Number of points in grid
M = 100; % Number of time steps
x_start = 0;
x_end = 100;
x_grid = linspace(x_start, x_end, N);
dx = (x_end-x_start)/N;

t_start = 0;
dt = 0.8;

lambda = 1; %according to Hedda, need to check this
q0 = 0.1;
xs = x_end/3;
xf = x_end*(2/3);
slope = -0.05;
b = q0-slope*xs; %calculate intersec s.t. y(x) = slope*x+b = q0 at xs
q = @(x) b+slope*x;


%% Initialize glacier and source q(x)
qq = zeros(1,N);
q_control = 2 %1 = constant, 2 = variable

if q_control == 1
    qq = ones(1,N); %constant
elseif q_control == 2
    for i=1:N
        x = x_start+dx*i;
         if(x <xs)
                qq(1,i) = q0;
            elseif x > xf
                qq(1,i) = 0;
            else
                qq(1,i) = q(x);
         end
    end
end


h = zeros(M,N);
h0 = @(x) max(0,-((x-50)/5).^2+100); %make an initial shape 
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

subplot(3,1,2)
plot(x_grid, h(1,1:N))
title('Starting glacier h(x,t=0)')

for i=1:M
    subplot(3,1,3)
    plot(x_grid, h(i,1:N));
    axis([x_start x_end 0 100]);
    title(['time = ', num2str(i), ' of ', num2str(M)]) 
    pause(0.2);
end

mtx = h;
end 

