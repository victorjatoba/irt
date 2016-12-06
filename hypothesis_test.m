% IRT algorithm calculator
% Ref.: [BOOK] Andrade, TRI Conceitos e Aplicações 
%       http://egov.ufsc.br/portal/sites/default/files/livrotri.pdf
%
% Author: Victor Jatoba
% Date: 11/18/16 [mm/dd/yy]

Num_students = 1;
Num_items = 1000;

% Initialize attributes values
a = rand(1,Num_items);
b = rand(1,Num_items); % Generating N randon b
c = rand(1,Num_items); % Generating N randon b
D = 1;
theta = 0.7;

% Simulate N user responses known parametes
Num_simulations = 100;
U = generate_responses(Num_simulations, theta, a, b, c, D); % Generated 10 prove responses

% Initialize thetas estimators with normal values (values near zero)
theta_hat = deal(zeros(1,Num_simulations));

[result_theta, thetas_hat] = gradient_estimator_theta(1000, Num_simulations, U, a, b, c, D);

Erro_absoluto = abs(thetas_hat-theta);

media = sum(Erro_absoluto)/Num_simulations;
desvio_padrao = std(Erro_absoluto);

A = media - 1.96 * desvio_padrao;
B = media + 1.96 * desvio_padrao;
