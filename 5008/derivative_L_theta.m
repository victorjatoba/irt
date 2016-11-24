function thetas_hat = derivative_L_theta( thetas, Y, betas )
%DERIVATIVE_L_THETA % The equation of the theta derivate
%   Detailed explanation goes here


    y_it = 1; % the iterator of Y columns
    thetas_hat = [];

    for i=1:size(thetas,2)
    theta_sum = 0;
        for j=1:size(betas,2)

            theta_i = thetas(1,i);
            beta_j = betas(1,j);

            theta_sum = theta_sum + ((Y(1, y_it) * (1 / (1 + exp(theta_i*beta_j))) * beta_j) - ((1 - Y(1, y_it)) * logito(theta_i*beta_j) * beta_j));
            y_it = y_it+1;
        end
        thetas_hat(i) = theta_sum;
    end

end

