function b_hat = derivative_b( U, theta,a,b,c,D )
%DERIVATIVE_B Derivative of difficult parameter (Reff.: Andrade 3.15)
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, b, c, D: items parameters

    % result = -D.* a.* (1-c).* sum((Y - Pji(theta,a,b,c,D)).* Wji(theta,a,b,c,D));
    
    b_hat = [];
    N = size(theta,2); % N = students awnsers set (j = 1, ..., N)
    I = size(b,2); % I = item set (i = 1, ..., I)

    for i=1:I
        b_sum = 0;
        a_i = a(1,i);
        b_i = b(1,i);
        c_i = c(1,i);
        
        for j=1:N

            theta_j = theta(1,j);

            b_sum = b_sum + ((U(j, i) - Pji(theta_j, a_i, b_i, c_i, D)) * Wji(theta_j, a_i, b_i, c_i, D));
        end
        b_hat(i) = b_sum * (-D * a_i * (1 - c_i));
    end
end

