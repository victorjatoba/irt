% IRT algorithm calculator
% Ref.: [BOOK] Andrade, TRI Conceitos e Aplicações 
%       http://egov.ufsc.br/portal/sites/default/files/livrotri.pdf
%
% Author: Victor Jatoba
% Date: 11/18/16 [mm/dd/yy]

%N_items = 175;
%N_students = 1414;
Num_students = 10;
Num_items = 1000;

% Initialize attributes values

a = rand(1,Num_items);
%a = deal(ones(1,Num_items)); % Generating N randon b
%a = 1;
%a = [0.5,1,1.3];
%a = 1.3;

b = rand(1,Num_items); % Generating N randon b
%b = deal(ones(1,Num_items)); % Generating N randon b
%b = [1,1,1.5];
%b = 1.5;

c = rand(1,Num_items); % Generating N randon b
%c = deal(ones(1,Num_items)); % Generating N randon b
%c = 1;
%c = [0,0,0.2];
%c = 0.2;

%theta = 1;
theta = deal(ones(1,Num_students));
%theta = randn(1,Num_students);

D = 1;

%{
% Simulate N user responses known parametes
P = Pji(theta,a,b,c,D);
U = P > rand(1,Num_items); % fill the Y vector, that contains the probabilities
%}
%log_like = log_likelihood(Y, theta, a, b, c, D);

U = fill_responses(theta, a, b, c, D);

% Initialize thetas estimators with normal values (values near zero)
theta_hat = deal(zeros(1,Num_students));

% Birbaum (1968) Method to estimate thetas and items params
for i=1:100
    [result_a, result_b, result_c, a_hat, b_hat, c_hat] = gradient_estimator_item(2000, Num_items, Y, thetas_hat, D);

    [result_theta, thetas_hat] = gradient_estimator_theta(2000, Num_students, Y, a_hat, b_hat, c_hat, D);
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