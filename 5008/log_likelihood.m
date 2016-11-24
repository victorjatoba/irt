function thetas_hat = log_likelihood( thetas, Y, betas )
%LOGITO Log likelihood function
%   Retorn the thetas estimators
%   Author: Victor Jatoba
%   Date: 11/16/16 [mm/dd/yy]

    y_it = 1; % the iterator of Y columns
    theta_sum = 0;
    thetas_hat = [];

    for i=1:size(thetas,2)
        for j=1:size(betas,2)

            theta_i = thetas(1,i);
            beta_j = betas(1,j);

            theta_sum = theta_sum + (Y(1, y_it) * log(logito(theta_i*beta_j))) + ((1 - Y(1, y_it)) * log(1/(1 + exp(theta_i*beta_j))));
            y_it = y_it+1;
        end
        thetas_hat(end+1) = theta_sum;
    end

end

