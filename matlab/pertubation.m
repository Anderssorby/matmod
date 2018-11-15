function pertubation()
%PERTUBATION Solve the pertubtion equation
%   Solve equation

N = 100;
x_start = 0;
x_end = 10;
L = x_end - x_start;
x_grid = linspace(x_start, x_end, N);
dx = (x_end-x_start)/N;

% Make time grid
M = 100; 
t_start = 0;
t_end = 10;
dt = (t_end-t_start)/M;


%% Initialize glacier and source q(x)
xf = 10;
%Q = zeros(M,N);
%initialQ = getSource(x_grid,xf,2);
%Q(1,1:N) = initialQ;
delta = 0.1;
h0 = initialGlacier(x_grid,xf,2);
k0 = delta*sin(pi/L*x_grid);
k = zeros(M,N);
k(1,1:N) = k0;
%k(1:M,1:2) = k0(1);  

%% Upwind scheme  (FTBS)
m = 3; %from glen's law
kappa = 1; %need to check this
for j=1:M-1 %time *(m+2)*h(j,i)
    %q_indicator = (x_grid<xf);
    %Q(j+1,1:N) = Q(1,1:N).*q_indicator;
    for i=2:N %space
        k(j+1,i) = k(j,i)  + kappa*(dt/dx)*(k(j,i-1)*h0(i-1)^(m+1)-k(j,i)*h0(i)^(m+1));
    end
    %xf = x_grid(find(max(k(j+1, 1:N), 0) == 0, 1, 'first'));
end
difference =  k(1:M-1,1:N)-k(2:M,1:N);

%% PLOTTING
plotIndicator = 1;

path_name = 'plots';

if plotIndicator == 1
    plots = 4;
    figure(1);
    subplot(plots,1,1)
    plot(x_grid, k(1,1:N))
    title('Starting pertubation k(x,t=0)')
    axis([x_start x_end 0 1]);
    for j=1:M
        figure(1);
        subplot(plots,1,2)
        plot(x_grid, k(j,1:N));
        axis([x_start x_end -0.5 2]);
        title(['Pertubation k(x,t) at time = ', num2str(j), ' of ', num2str(M)]); 

        subplot(plots,1,3)
        plot(x_grid, h0(1:N) + delta*k(j,1:N));
        axis([x_start x_end -0.5 2]);
        title(['Glacier profile h_\delta = h_0 + \delta k at time = ', num2str(j), ' of ', num2str(M)]); 
        
        %pause(0.01);
        %figure(2);
        subplot(plots,1,4)
        plot(x_grid, k(j,1:N));
        axis([x_start x_end -0.5 2]);
        title(['Difference k(x,t) at time = ', num2str(j), ' of ', num2str(M)]); 

        
        %title(['time = ', num2str(j), ' of ', num2str(M)]) 
        %filename = num2str(j);
        %saveas(gcf,fullfile(path_name, filename), 'png');
        pause(0.04);
    end %for loop
end %plot indicator
end

