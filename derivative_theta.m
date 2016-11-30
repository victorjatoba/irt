function thetas_hat = derivative_theta( U,theta,a,b,c,D )
%DERIVATIVE_THETA Derivative of theta parameter (eq.: 3.39)
%   result = D.*sum((a.*(1-c)).* (Y-Pji(theta,a,b,c,D)).*Wji(theta,a,b,c,D));
%   
    thetas_hat = [];
    N = size(theta,2); % N = students awnsers set (j = 1, ..., N)
    I = size(b,2); % I = item set (i = 1, ..., I)

    for j=1:N
        theta_sum = 0;
        for i=1:I

            theta_j = theta(1,j);
            a_i = a(1,i);
            b_i = b(1,i);
            c_i = c(1,i);

            %theta_sum = theta_sum + ((Y(1, y_it) * (1 / (1 + exp(theta_i*beta_j))) * beta_j) - ((1 - Y(1, y_it)) * logito(theta_i*beta_j) * beta_j));
            theta_sum = theta_sum + ((a_i * (1 - c_i)) * (U(j, i) - Pji(theta_j, a_i, b_i, c_i, D)) * Wji(theta_j, a_i, b_i, c_i, D));
        end
        thetas_hat(j) = theta_sum * D;
    end

end

