%%%%%%%%%%%%%% FLOW FIELD %%%%%%%%%%%%%%
clc; clear;
%%%% DECLARE CONSTANTS %%%%
H = 1;   %% Height of domain
L = 30;  %% Length of domain
Q = 5;
Theta = 7;
m = 3;

epsilon = H/L;
kappa = 2*epsilon*H/Q*Theta*abs(Theta)^(m-1);
lambda = kappa/(m+2);

h0 = 0.9;
q0 = 1;
xf = 1; %% Toe of glacier / Length of domain
xs = 0.4; 
% r1 = 2*(q0*xf-h0)/((xf-xs)^2); %% Finding rate r in function q(x)
r = get_r(xs, xf, q0, h0, lambda, m)-0.001;
nx = 30; %% Steps in x direction
nz = 30; %% Steps in z direction

xt = xs + q0/r;

%%%% GRID NODES %%%%
x_vec = linspace(0, xf, nx);
z_vec = linspace(0, H, nz);

%%%% CHECK IF q(x) SUMS TO ZERO WITH SELECTED r %%%%
%[A, B, C, total] = areas(xs, xf, q0, r); %% A + B = C
[A, B, C, total] = areas2(xs, xf, q0, r, h0); %% A + B = C + h0

%%%% IMPORTANT FUNCTIONS %%%%
q = @(x) q_func(x, xs, xf, q0, r);
h = @(x) h_func(x, xs, xf, q0, h0, r, lambda, m);
[htrapes] = h_trapes(q, x_vec, xt, h0, lambda, m);
h_der = @(x) h_der_func(x, xs, xf, q0, h0, r, lambda, m);

%%%% VELOCITY MATRICES %%%%
U = zeros(nz, nx);
for i = 1:nx
    for j = 1:nz
        U(j,i) = u_func(x_vec(i), z_vec(j), h, 0, kappa, m);
    end
end

V = zeros(nz, nx);
for i = 1:nx
    for j = 1:nz
        V(j,i) = v_func(x_vec(i), z_vec(j), h, h_der, 0, 0, kappa, m);
    end
end

%%%% PLOTS %%%%
figure(1)
subplot(2,2,1)
[qvec] = plot_q(xs, xf, q0, r);
title('q(x)')

subplot(2,2,2)
[hmax, h_vec] = plot_h(xs, xf, q0, h0, r, lambda, m, nx);
title('h(x)')

subplot(2, 2, 3)
% image(U)
imshow(mat2gray(U))
title('U')

subplot(2, 2, 4)
% image(V)
imshow(mat2gray(V))
title('V')

figure(2)
quiver(U,V)

figure(3)
plot_h_with_flow(U, V, nx, nz, xf, hmax, h_vec, H, L)

xt = xs + q0/r;
figure(4)
plot(x_vec, htrapes)
hold on
line([xt xt], [0 1.5])
