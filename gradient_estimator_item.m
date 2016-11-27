function [ result_a, result_b, result_c, a_hat, b_hat, c_hat ] = gradient_estimator_item( NumIterations, N, Y, theta, a, b, c, D )
%GRADIENT_ESTIMATOR_ITEM Item params estimator with Gradient method
%   NumIterations: Number of the loop itarations
%   N: params lenth
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, betas, c, D: items parameters

    a_hat = deal(zeros(1,N)); % Initialize vector of N zeros
    b_hat = deal(zeros(1,N));
    c_hat = deal(zeros(1,N));

    alpha = 0.0001;
    result_a = [];
    result_b = [];
    result_c = [];
    for i=1:NumIterations

       result_a = [result_a; [a_hat log_likelihood(Y, theta, a_hat, b, c, D)]];
       a_hat = a_hat + alpha * derivative_a(Y, theta, a_hat, b, c, D);
    %{
       result_b = [result_b; [b_hat log_likelihood(Y, theta, a, b_hat, c, D)]];
       b_hat = b_hat + alpha * derivative_b(theta, a, b_hat, c, D);

       result_c = [result_c; [c_hat log_likelihood(Y, theta, a, betas,c_hat,D)]];
       c_hat = c_hat + alpha * derivative_c(theta,a,betas,D);
    %}
    end

end

