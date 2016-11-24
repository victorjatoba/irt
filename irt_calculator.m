% Desenvolvendo algoritmo para calculo simples TRI
% Ref.: [BOOK] Andrade, TRI Conceitos e Aplicações 
%       http://egov.ufsc.br/portal/sites/default/files/livrotri.pdf
%
% Author: Victor Jatoba
% Date: 11/18/16 [mm/dd/yy]

N = 1000;

% Attributes
betas = rand(1,N); % Generating N randon betas
c = rand(1,N); % Generating N randon betas
a = deal(ones(1,N)); % Generating N randon betas
theta = 1.0;
D = 1;

L = @(theta,a,b,D) D.*a.*(theta-b); % Logistic deviation
Pji = @(theta,a,b,c,D) c + (1 - c).* 1./(1 + exp(-L(theta,a,b,D))); % Logit function ML3
Qji = @(theta,a,b,c,D) 1 - Pji(theta,a,b,c,D);

P_star = @(theta,a,b,D) 1./(1 + exp(-L(theta,a,b,D))); % Logit function ML2
Q_star = @(theta,a,b,D) 1 - P_star(theta,a,b,D);
Wji = @(theta,a,b,c,D) (P_star(theta,a,b,D).*Q_star(theta,a,b,D))./ (Pji(theta,a,b,c,D).*Qji(theta,a,b,c,D)); % Ponderacao

% Log likelihood Function
log_likelihood = @(Y,theta,a,b,c,D) sum(Y.* log(Pji(theta,a,b,c,D)) + (1 - Y).* log(Qji(theta,a,b,c,D)));

% Derivative of theta parameter
derivative_theta = @(Y,theta,a,b,c,D) D.*sum((a.*(1-c)).* (Y-Pji(theta,a,b,c,D)).*Wji(theta,a,b,c,D));

% Derivative of discrimination parameter
derivative_a = @(theta,a,b,c,D) D.* (1-c).* (theta - b).* P_star(theta,a,b,D).* Q_star(theta,a,b,D);

% Derivative of difficult parameter
derivative_b = @(theta,a,b,c,D) -D.* a.* (1-c).* P_star(theta,a,b,D).* Q_star(theta,a,b,D);

% Derivative of guessing parameter
derivative_c = @(theta,a,b,D) Q_star(theta,a,b,D);

% Simulate N user responses known parametes
P = Pji(theta,a,betas,c,D);
Y = P > rand(1,N); % fill the Y vector, that contains the probabilities

% Implementing Gradient method to estimate theta
theta_hat = 0;
alpha = 0.0001;
result = [];
for i=1:2000
   result = [result; [theta_hat log_likelihood(Y, theta_hat, a, betas, c, D)]];
   theta_hat = theta_hat + alpha * derivative_theta(Y, theta_hat, a, betas, c, D);
end
%%%%

% Implementing Gradient method to estimate theta
a_hat = deal(zeros(1,N)); % Initialize vector of N zeros
b_hat = deal(zeros(1,N));
c_hat = deal(zeros(1,N));

alpha = 0.0001;
result_a = [];
result_b = [];
result_c = [];
for i=1:2000
   result_a = [result_a; [a_hat log_likelihood(Y, theta, a_hat, betas, c, D)]];
   a_hat = a_hat + alpha * derivative_a(theta, a_hat, betas, c, D);
   
   result_b = [result_b; [b_hat log_likelihood(Y, theta, a, b_hat, c, D)]];
   b_hat = b_hat + alpha * derivative_b(theta, a, b_hat, c, D);
   
   result_c = [result_c; [c_hat log_likelihood(Y, theta, a, betas,c_hat,D)]];
   c_hat = c_hat + alpha * derivative_c(theta,a,betas,D);
end
%%%%

%{
subplot(2,1,1);
plot(result_a(:,1));
subplot(2,1,2);
plot(result_a(:,2));
%}

figure;
hold on
for i = 1:10
    plot(result_a(:,i))
end
