function a_hat = derivative_a( U,theta,a,b,c,D )
%DERIVATIVE_A Derivative of discrimination parameter (Reff.: Andrade, 3.14)
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, b, c, D: items parameters

    %result = D.* (1-c).* sum((Y-Pji(theta,a,b,c,D)).* (theta-b).* Wji(theta,a,b,c,D));
    
    a_hat = [];
    N = size(theta,2); % N = students awnsers set (j = 1, ..., N)
    I = size(b,2); % I = item set (i = 1, ..., I)

    for i=1:I
        a_sum = 0;
        a_i = a(1,i);
        b_i = b(1,i);
        c_i = c(1,i);
        
        for j=1:N

            theta_j = theta(1,j);

            a_sum = a_sum + ((U(j, i) - Pji(theta_j, a_i, b_i, c_i, D)) * (theta_j - b_i) * Wji(theta_j, a_i, b_i, c_i, D));
        end
        a_hat(i) = a_sum * (D * (1 - c_i));
    end
end

