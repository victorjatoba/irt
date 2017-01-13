% IRT algorithm calculator
% Ref.: [BOOK] Andrade, TRI Conceitos e Aplicações 
%       http://egov.ufsc.br/portal/sites/default/files/livrotri.pdf
%
% Author: Victor Jatoba
% Date: 11/18/16 [mm/dd/yy]

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
initial_c_hat = [];
for i=1:Num_items
    initial_c_hat(i) = 1/5;
end

theta_hat = initial_theta_hat;
a_hat = initial_a_hat;
b_hat = initial_b_hat;
c_hat = initial_c_hat;

result_a_final = [];
result_b_final = [];
result_c_final = [];
result_theta_final = [];

% Birbaum (1968) Method to estimate thetas and items params
for i=1:3
    [result_a, result_b, result_c, a_hat, b_hat, c_hat] = gradient_estimator_item(1, U, theta_hat, D, a_hat, b_hat, c_hat);
    
    [result_theta, theta_hat] = gradient_estimator_theta(1, Num_students, U, a_hat, b_hat, c_hat, D, theta_hat);
    
    % storing birbaum evolution
    result_a_final = [result_a_final; a_hat];
    result_b_final = [result_b_final; b_hat];
    result_c_final = [result_c_final; c_hat];
    result_theta_final = [result_theta_final; theta_hat];
end

toc;

% print_results(Num_students, Num_items, result_theta, result_a, result_b, result_c, 1);