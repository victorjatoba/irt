% 5.2 a, b e c items
%
% Ref.: Aula_09_Otimizacao.pdf (Valdinei - SIN5008 Estatistica Computacional)
%
% Author: Victor Jatoba
% Date: 11/11/16 [mm/dd/yy]

N = 1000;

betas = rand(1,N); % Generating N randon betas1
%betas = [0 1 0 1 0 1 0 1 0 1];
thetas = [1 1 1 1 1];
%thetas = rand(1,N);
%thetas = 1;

logito = @(x) exp(x)./(1 + exp(x)); % Logit function
Y = [];

for i=1:size(thetas,2)

    for j=1:size(betas,2)
        theta_i = thetas(1,i);
        beta_j = betas(1,j);
        
        P = logito(theta_i*beta_j);

        % probability = round(P); % round to nearest integer

        if(P > rand(1,1))
            y = 1;
        else
            y = 0;
        end
        
        Y(end+1) = y;
        
    end
end

% Implementing Gradient method to estimate theta
 thetas_hat = [0 0 0 0 0];
%thetas_hat = rand(1,N);
%thetas_hat = 0;
alpha = 0.0001;
result = [];
for i=1:1000
   %log_likelihood(thetas_hat, Y, betas);
   result = [result; [thetas_hat]];
   %thetas_hat
   thetas_hat = thetas_hat + alpha * derivative_L_theta(thetas_hat, Y, betas);
end

%subplot(2,1,1);
%plot(result(:,1));
%subplot(2,1,2);
%plot(result(:,2));

figure;
hold on
for i = 1:N
    plot(result(:,i))
end
