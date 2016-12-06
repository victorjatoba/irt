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
theta_hat = randn(1,Num_students);

% Birbaum (1968) Method to estimate thetas and items params
for i=1:3
    [result_a, result_b, result_c, a_hat, b_hat, c_hat] = gradient_estimator_item(200, Num_items, U, theta_hat, D);

    [result_theta, thetas_hat] = gradient_estimator_theta(2000, Num_students, U, a_hat, b_hat, c_hat, D);
end

%{
subplot(2,1,1);
plot(result_c(:,1));
xlabel('iterations number')
ylabel('estimator');

subplot(2,1,2);
plot(result_c(:,2));
xlabel('iterations number')
ylabel('estimator');
%}

%{
% theta param

figure;
hold on
for i = 1:Num_students
    plot(result_theta(:,i));
    
end
xlabel('iterations number');
ylabel('estimator');
title('Theta Estimator Graph');
legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');


% a param

figure;
hold on
for i = 1:Num_items
    plot(result_a(:,i));
    
end
xlabel('iterations number');
ylabel('estimator');
title('a Estimator Graph');
legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');

% b param
figure;
hold on
for i = 1:Num_items
    plot(result_b(:,i));
    
end
xlabel('iterations number');
ylabel('estimator');
title('b Estimator Graph');
legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');

% c param
figure;
hold on
for i = 1:Num_items
    plot(result_c(:,i));
    
end
xlabel('iterations number');
ylabel('estimator');
title('c Estimator Graph');
legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');
%}

toc;