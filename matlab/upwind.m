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
M = 1000; 
t_start = 0;
t_end = 1;
dt = (t_end-t_start)/M;


%% Initialize glacier and source q(x)
xf = 8;
Q = zeros(M,N);
Q(1,1:N) = getSource(x_grid,xf);

h0 = initialGlacier(x_grid,xf);
h = zeros(M,N);
h(1,1:N) = h0;
h(1:M,1:2) = h0(1);  




%% Upwind scheme  (FTBS)
m = 3; %from glen's law
lambda = 1; %need to check this

for j=1:M %time *(m+2)*h(j,i)
        Q(j,1:N) = getSource(x_grid, xf);
        for i=2:N %space
          h(j+1,i) = h(j,i) + Q(j,i)*dt + lambda*(dt/dx)*(h(j,i-1)^(m+2)-h(j,i)^(m+2));
        end
        xf = x_grid(find(max(h(j+1, 1:N), 0) == 0, 1, 'first'));
end


%% PLOTTING
%h_new = max(0,h);
h_new = h;


subplot(3,1,1)
plot(x_grid, h_new(1,1:N))
title('Starting glacier h(x,t=0)')
axis([x_start x_end 0 1]);

for j=1:M
    subplot(3,1,2)
    plot(x_grid, Q(j,1:N));
    title('Source function q(x)');
    axis([x_start x_end -2 2]);
    title(['source function q(x) at time  = ', num2str(j), ' of ', num2str(M)]) 

    subplot(3,1,3)
    plot(x_grid, h_new(j,1:N));
    axis([x_start x_end 0 2]);
    title(['time = ', num2str(j), ' of ', num2str(M)]) 
    pause(0.005);
end

mtx = h;
end 