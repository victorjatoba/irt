function [result, theta_hat] = gradient_theta_estimator( Y, c, D, a, b )
% GRADIENT_METHOD The gradient method for theta parameter estimation
%   This is the implementation of the Gradient method to estimate the
%   theta parameter using log derivative of likelihood function
%   Author: Victor Jatoba
%   Date: 11/20/16 [mm/dd/yy]

    theta_hat = 0;
    alpha = 0.0001;
    result = [];
    for i=1:2000
       result = [result; [theta_hat log_likelihood(Y, theta_hat, c, D,a,betas)]];
       theta_hat = theta_hat + alpha * derivative_L_theta(Y, theta_hat, c, D,a,betas);
    end

    result = exp(x)./(1 + exp(x));
end
