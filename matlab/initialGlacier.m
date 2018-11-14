function glacier = initialGlacier(x_grid, xf, initialChoice)
    N = length(x_grid);
    glacier = zeros(1,N);
    if initialChoice == 1
         glacier = cos(x_grid*pi/(2*xf));  
    elseif initialChoice == 2
        q_intial = getSource(x_grid, xf, 1);
        for i=1:N
            lambda = 1;
            m = 3;
            c = 1;
            integral = trapz(q_intial(1,1:i))+c;
            glacier(1,i) = (1/lambda)*integral;
        end
    end
    glacier = glacier/max(glacier);
end
