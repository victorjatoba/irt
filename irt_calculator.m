% IRT algorithm calculator
% Ref.: [BOOK] Andrade, TRI Conceitos e Aplicações 
%       http://egov.ufsc.br/portal/sites/default/files/livrotri.pdf
%
% Author: Victor Jatoba
% Date: 11/18/16 [mm/dd/yy]

N = 10;

% Initialize attributes values

betas = rand(1,N); % Generating N randon betas
%betas = 1;
c = rand(1,N); % Generating N randon betas
%c = 1;
a = deal(ones(1,N)); % Generating N randon betas
%a = 1;
% theta = 1.0;
% theta = deal(ones(1,N));
theta = rand(1,N);
D = 1;

% Simulate N user responses known parametes
P = Pji(theta,a,betas,c,D);
Y = P > rand(1,N); % fill the Y vector, that contains the probabilities

% gradient_estimator_theta(2000, Y, a, betas, c, D);

[result_a, result_b, result_c, a_hat, b_hat, c_hat] = gradient_estimator_item(10000, N, Y, theta, a, betas, c, D);

subplot(2,1,1);
plot(result_c(:,1));
xlabel('iterations number')
ylabel('estimator');


subplot(2,1,2);
plot(result_c(:,2));
xlabel('iterations number')
ylabel('estimator');


figure;
hold on
for i = 1:N
    plot(result_c(:,i));
    
end
xlabel('iterations number');
ylabel('estimator');
title('Graph of a estimator');
legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');