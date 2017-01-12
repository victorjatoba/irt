function result = log_likelihood_item( U,theta,a,b,c,D )
%LOG_LIKELIHOOD Log likelihood Function
%   log_likelihood = @(Y,theta,a,b,c,D) sum(Y.* log(Pji(theta,a,b,c,D)) + (1 - Y).* log(Qji(theta,a,b,c,D)));
%   result = sum(Y.* log(Pji(theta,a,b,c,D)) + (1 - Y).* log(Qji(theta,a,b,c,D)));

    N = size(theta,2); % N = students awnsers set (j = 1, ..., N)
    I = size(b,2); % I = item set (i = 1, ..., I)

    for i=1:I
        result_sum = 0;
        a_i = a(1,i);
        b_i = b(1,i);
        c_i = c(1,i);
        for j=1:N
            theta_j = theta(1,j);
            
            result_sum = result_sum + ((U(j,i) * log(Pji(theta_j,a_i,b_i,c_i,D))) + ((1 - U(j,i)) * log(Qji(theta_j,a_i,b_i,c_i,D))));
        end
        result(i) = result_sum;
    end

end

