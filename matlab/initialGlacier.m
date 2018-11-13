function glacier = initialGlacier(x_grid, xf)
    N = length(x_grid);
    glacier = cos(x_grid*pi/(2*xf));
end
