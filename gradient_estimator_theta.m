function [ result, theta_hat ] = gradient_estimator_theta( NumIterations, Y, a, b, c, D )
%GRADIENT_ESTIMATOR_THETA Theta param estimator with Gradient method
%   NumIterations: Number of the loop itarations
%   Y: Set of the users responses
%   a, betas, c, D: item parameters

theta_hat = 0;
alpha = 0.0001;
result = [];
for i=1:NumIterations
   result = [result; [theta_hat log_likelihood(Y, theta_hat, a, b, c, D)]];
   theta_hat = theta_hat + alpha * derivative_theta(Y, theta_hat, a, b, c, D);
end

end

