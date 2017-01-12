function [ result_a, result_b, a_hat, b_hat] = ml2_gradient_estimator_item( NumIterations, Y, theta, D, a_hat, b_hat)
%GRADIENT_ESTIMATOR_ITEM Item params estimator with Gradient method
%   NumIterations: Number of the loop itarations
%   N: params lenth
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, b, c, D: items parameters

    a_ant = a_hat;
    b_ant = b_hat;
   
    alpha = 0.0001;
    result_a = [];
    result_b = [];
    for i=1:NumIterations
       result_a = [result_a; [a_ant ml2_log_likelihood_item(Y, theta, a_ant, b_ant, D)]];
       a_hat = a_ant + alpha * ml2_derivative_a(Y, theta, a_ant, b_ant, D);

       result_b = [result_b; [b_ant ml2_log_likelihood_item(Y, theta, a_ant, b_ant, D)]];
       b_hat = b_ant + alpha * ml2_derivative_b(Y, theta, a_ant, b_ant, D);
        
       a_ant = a_hat;
       b_ant = b_hat;
    end

end

