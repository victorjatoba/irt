% 5.2 a, b e c items
%
% Ref.: Aula_09_Otimizacao.pdf (Valdinei - SIN5008 Estatistica Computacional)
%
% Author: Victor Jatoba
% Date: 11/09/16 [mm/dd/yy]

% import data
delimiterIn = ' ';
headerlinesIn = 0;
A = importdata('data.txt', delimiterIn, headerlinesIn);

fileY = fopen('dataY.txt','a+');

% fill dataY
for i=1:10
    
    for j=1:10
        theta_i = A(1,i);
        beta_j = A(2,j);
        
        e = exp(theta_i * beta_j);

        P = e / (1 + e);

        % probability = round(P); % round to nearest integer

        if(P > 0.5)
            y = 1;
        else
            y = 0;
        end
        
        fprintf(fileY, '%d ', y);
        %fprintf(fileY,'% g', y);
        
    end
end

type dataY.txt;
fclose(fileY);
% calculate the maximum likelihood estimator (MLE)

