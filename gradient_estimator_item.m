function [ result_a, result_b, result_c, a_hat, b_hat, c_hat ] = gradient_estimator_item( NumIterations, Y, theta, D, a_hat, b_hat, c_hat)
%GRADIENT_ESTIMATOR_ITEM Item params estimator with Gradient method
%   NumIterations: Number of the loop itarations
%   N: params lenth
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, b, c, D: items parameters

    a_ant = a_hat;
    b_ant = b_hat;
    c_ant = c_hat;
   
    alpha = 0.0001;
    result_a = [];
    result_b = [];
    result_c = [];
    for i=1:NumIterations
       result_a = [result_a; [a_ant log_likelihood_item(Y, theta, a_ant, b_ant, c_ant, D)]];
       a_hat = a_ant + alpha * derivative_a(Y, theta, a_ant, b_ant, c_ant, D);

       result_b = [result_b; [b_ant log_likelihood_item(Y, theta, a_ant, b_ant, c_ant, D)]];
       b_hat = b_ant + alpha * derivative_b(Y, theta, a_ant, b_ant, c_ant, D);

       result_c = [result_c; [c_ant log_likelihood_item(Y, theta, a_ant, b_ant,c_ant,D)]];
       c_hat = c_ant + alpha * derivative_c(Y, theta, a_ant, b_ant, c_ant, D);
        
       a_ant = a_hat;
       b_ant = b_hat;
       c_ant = c_hat;
    end

end

