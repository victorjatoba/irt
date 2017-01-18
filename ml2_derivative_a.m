function a_hat = ml2_derivative_a( U,theta,a,b,D )
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
        
        for j=1:N

            theta_j = theta(1,j);

            a_sum = a_sum + ( ((U(j, i) - ml2_Pji(theta_j, a_i, b_i, D)) / (ml2_Pji(theta_j, a_i, b_i, D).*ml2_Qji(theta_j, a_i, b_i, D)) ) .* -( (D*(theta_j-b_i) .* exp(L(theta_j,a_i,b_i,D))) / ((1 + exp(L(theta_j,a_i,b_i,D))).^2) ) );
        end
        a_hat(i) = a_sum;
    end
end
