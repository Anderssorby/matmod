function plot_h_with_flow(U, V, nx, nz, xf, hmax, hvec, H, L)

% hvec = hvec/hmax;

xx = linspace(0,xf,nx);
zz = linspace(0,round(hmax),nz);

logics = zeros(nz, nx);
for i = 1:nx
    for j = 1:nz
        if zz(j) > hvec(i)
            logics(j,i) = nan;
        end
    end
end
% xx = linspace(0,H,nx);
% zz = linspace(0,L,nz);
quiver(xx, zz ,U+logics,V+logics, 'Color',[0,0.7,0.9])
hold on;
plot(xx, hvec, 'Color',[0,0,0], 'LineWidth', 2)
end