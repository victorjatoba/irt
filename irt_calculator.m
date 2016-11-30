% IRT algorithm calculator
% Ref.: [BOOK] Andrade, TRI Conceitos e Aplicações 
%       http://egov.ufsc.br/portal/sites/default/files/livrotri.pdf
%
% Author: Victor Jatoba
% Date: 11/18/16 [mm/dd/yy]

%N_items = 175;
%N_students = 1414;
Num_items = 100;
Num_students = 10;

% Initialize attributes values

b = rand(1,Num_items); % Generating N randon b
%b = 1;
c = rand(1,Num_items); % Generating N randon b
%c = 1;
a = rand(1,Num_items);
% a = deal(ones(1,Num_items)); % Generating N randon b
%a = 1;
% theta = 1.0;
theta = deal(ones(1,Num_students));
% theta = rand(1,Num_students);
D = 1;

%{
% Simulate N user responses known parametes
P = Pji(theta,a,b,c,D);
Y = P > rand(1,Num_items); % fill the Y vector, that contains the probabilities
%}

Y = fill_responses(theta, a, b, c, D);

[result_theta, thetas_hat] = gradient_estimator_theta(2000, Num_students, Y, a, b, c, D);

% [result_a, result_b, result_c, a_hat, b_hat, c_hat] = gradient_estimator_item(10000, Num_items, Y, theta, a, b, c, D);

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

%{
% a param

figure;
hold on
for i = 1:Num_items
    plot(result_c(:,i));
    
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

% b param
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