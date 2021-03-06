[glac, src] = upwind();
clf; 

N = 100;
x_start = 0;
x_end = 10;
x_grid = linspace(x_start, x_end, N);

subplot(3,1,[1,2])
plot(x_grid, glac(1,1:N),'g')
hold on
plot(x_grid, glac(50,1:N))
hold on
plot(x_grid, glac(100,1:N))
hold on
plot(x_grid, glac(250,1:N))
hold on
plot(x_grid, glac(500,1:N))
hold on
plot(x_grid, glac(750,1:N))
hold on
plot(x_grid, glac(1000,1:N))
hold on

title('Glacier profile');
axis([x_start x_end -0.5 2]);
legend('t = 1', 't=50','t=100','t=250', 't=500', 't=750','t=1000', 'source');
xlabel('x');
ylabel('h(x,t)');

subplot(3,1,3)
plot(x_grid, src(1,1:N))
%{
hold on
plot(x_grid, src(50,1:N))
hold on
plot(x_grid, src(100,1:N))
hold on
plot(x_grid, src(250,1:N))
hold on
plot(x_grid, src(500,1:N))
hold on
plot(x_grid, src(750,1:N))
hold on
plot(x_grid, src(1000,1:N))

legend('t = 1', 't=50','t=100','t=250', 't=500', 't=750','t=1000');
%}
title('Initial source function');
axis([x_start x_end -2 2]);
xlabel('x');
ylabel('q(x)');
orient = 'landscape';