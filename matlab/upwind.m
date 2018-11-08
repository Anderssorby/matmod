%%% ANDERS HJORT
%%% Attempt on solving h_t + lambda*(d/dx)h^(m+2) = q(x) via upwind scheme

function mtx = upwind()
% Make X grid
N = 100;
x_start = 0;
x_end = 10;
x_grid = linspace(x_start, x_end, N);
dx = (x_end-x_start)/N;

% Make time grid
M = 100; 
t_start = 0;
t_end = 1;
dt = (t_end-t_start)/M;

%% Initialize glacier and source q(x)
qq = getSource(x_grid);
h0 = initialGlacier(x_grid);
h = zeros(M,N)
h(1,1:N) = h0
h(1:M,1) = h0(1)


%% Upwind scheme
m = 3 %from glen's law
lambda = 1; %need to check this

for j=1:M %time
    for i=2:N %space
        x = x_start+dx*i;
        h(j+1,i) = h(j,i) + qq(i)*dt+lambda*(dx/dt)*(h(j,i-1)-h(j,i));
    end
end

%% PLOTTING

subplot(3,1,1)
plot(x_grid, qq)
title('Source function q(x)')
axis([x_start x_end*1.5 -2 2]);

subplot(3,1,2)
plot(x_grid, h(1,1:N))
title('Starting glacier h(x,t=0)')
axis([x_start x_end*1.5 0 2]);

for i=1:M
    subplot(3,1,3)
    plot(x_grid, h(i,1:N));
    %axis([x_start x_end*1.5 0 2]);
    title(['time = ', num2str(i), ' of ', num2str(M)]) 
    pause(0.2);
end

mtx = h;
end 

