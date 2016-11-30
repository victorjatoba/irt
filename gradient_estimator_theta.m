function [ result, theta_hat ] = gradient_estimator_theta( Num_Iterations, Num_students, Y, a, b, c, D )
%GRADIENT_ESTIMATOR_THETA Theta param estimator with Gradient method
%   Num_Iterations: Number of the loop itarations
%   Num_students: Number of students
%   Y: Set of the users responses
%   a, betas, c, D: item parameters

    theta_hat = deal(zeros(1, Num_students)); % Initialize vector of N zeros
    alpha = 0.0001;
    result = [];
    for i=1:Num_Iterations
       result = [result; [theta_hat log_likelihood(Y, theta_hat, a, b, c, D)]];
       theta_hat = theta_hat + alpha * derivative_theta(Y, theta_hat, a, b, c, D);
       %theta_hat = theta_hat + alpha * old_derivative_theta(Y, theta_hat, a, b, c, D);
    end

end

