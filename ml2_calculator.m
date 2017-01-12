% ML2 IRT algorithm calculator
% Ref.: [BOOK] Andrade, TRI Conceitos e Aplicações 
%       http://egov.ufsc.br/portal/sites/default/files/livrotri.pdf
%
% Author: Victor Jatoba
% Date: 01/12/17 [mm/dd/yy]

% import data
tic;
U = importdata('matriz.txt', ' ', 0);

Num_students = size(U,1); %1414 responsers
Num_items = size(U,2); % 175 items

D = 1; % Constant value

% Initialize thetas estimators with normal values (values near zero)
initial_theta_hat = randn(1,Num_students);
% Initial estimators items params
initial_a_hat = randn(1,Num_items); %vector of zeros
initial_b_hat = randn(1,Num_items); %vector of zeros

theta_hat = initial_theta_hat;
a_hat = initial_a_hat;
b_hat = initial_b_hat;

% Birbaum (1968) Method to estimate thetas and items params
for i=1:3
    [result_a, result_b, a_hat, b_hat] = ml2_gradient_estimator_item(200, U, theta_hat, D, a_hat, b_hat);
    %plotar os likelihoods
    [result_theta, theta_hat] = ml2_gradient_estimator_theta(2000, U, a_hat, b_hat, D, theta_hat);
end

toc;

result_c = [];
print_results(Num_students, Num_items, result_theta, result_a, result_b, result_c, 1);