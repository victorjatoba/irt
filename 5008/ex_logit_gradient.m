% Example of use of Logit function with the Gradient Method with a 1 theta
% and various betas
%
% Author: Victor Jatoba
% Date: 11/11/16 [mm/dd/yy]

N = 1000;

betas = rand(1,N); % Generating N randon betas
theta = 1;

logito = @(x) exp(x)./(1 + exp(x)); % Logit function

P = logito(theta*betas);

Y = P > rand(1,N); % fill the Y vector, that contains the probabilities

% My code
log_likelihood_general = @(theta, Y, betas) sum(Y.* log(logito(theta*betas)) + (1 - Y).* log(1./(1 + exp(theta*betas))));
% The equation of the theta derivate
derivative_L_symmetric = @(theta, Y, betas) sum(Y.*(1./(1 + exp(theta*betas))).* betas - (1 - Y).*logito(theta*betas).* betas);

% Implementing Gradient method to estimate theta

theta_hat = 0;
alpha = 0.0001;
result = [];
for i=1:1000
   result = [result; [theta_hat log_likelihood_general(theta_hat, Y, betas)]];
   theta_hat = theta_hat + alpha * derivative_L_symmetric(theta_hat, Y, betas);
end

subplot(2,1,1);
plot(result(:,1));
subplot(2,1,2);
plot(result(:,2));