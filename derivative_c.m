function c_hat = derivative_c( U, theta,a,b,c,D )
%DERIVATIVE_B Derivative of difficult parameter (Reff.: Andrade 3.15)
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, b, c, D: items parameters
    
    % result = sum((Y - Pji(theta,a,b,c,D)).* (Wji(theta,a,b,c,D) ./ P_star(theta,a,b,D)) );
    
    c_hat = [];
    N = size(theta,2); % N = students awnsers set (j = 1, ..., N)
    I = size(b,2); % I = item set (i = 1, ..., I)

    for i=1:I
        c_sum = 0;
        a_i = a(1,i);
        b_i = b(1,i);
        c_i = c(1,i);
        
        for j=1:N

            theta_j = theta(1,j);

            c_sum = c_sum + ((U(j, i) - Pji(theta_j, a_i, b_i, c_i, D)) * (Wji(theta_j, a_i, b_i, c_i, D) / P_star(theta_j, a_i, b_i, D)) );
        end
        c_hat(i) = c_sum;
    end
end

