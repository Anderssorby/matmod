function glacier = initialGlacier(x_grid)
    N = length(x_grid);
    x_end = x_grid(N);
    a = cos(x_grid*pi/x_end);
    b = ones(1,N);
    weights_a = linspace(0,1,N);
    weights_b = linspace(1,0,N);
    glacier = max(0,a.*weights_a + b.*weights_b);
    %plot(x_grid, glacier);
end
