function [ result, theta_hat ] = ml2_gradient_estimator_theta( Num_Iterations, Y, a, b, D, theta_hat)
%GRADIENT_ESTIMATOR_THETA Theta param estimator with Gradient method
%   Num_Iterations: Number of the loop itarations
%   Num_students: Number of students
%   Y: Set of the users responses
%   a, betas, c, D: item parameters

    %theta_hat = deal(zeros(1, Num_students)); % Initialize vector of N zeros
    alpha = 0.0001;
    result = [];
    for i=1:Num_Iterations
       result = [result; [theta_hat ml2_log_likelihood(Y, theta_hat, a, b, D)]];
       theta_hat = theta_hat + alpha * ml2_derivative_theta(Y, theta_hat, a, b, D);
       %theta_hat = theta_hat + alpha * old_derivative_theta(Y, theta_hat, a, b, c, D);
    end

end

