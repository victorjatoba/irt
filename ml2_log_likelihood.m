function result = ml2_log_likelihood( U,theta,a,b,D )
%LOG_LIKELIHOOD Log likelihood Function
%   log_likelihood = @(Y,theta,a,b,c,D) sum(Y.* log(Pji(theta,a,b,c,D)) + (1 - Y).* log(Qji(theta,a,b,c,D)));
%   result = sum(Y.* log(Pji(theta,a,b,c,D)) + (1 - Y).* log(Qji(theta,a,b,c,D)));

    N = size(theta,2); % N = students awnsers set (j = 1, ..., N)
    I = size(b,2); % I = item set (i = 1, ..., I)

    for j=1:N
        result_sum = 0;
        for i=1:I
            theta_j = theta(1,j);
            a_i = a(1,i);
            b_i = b(1,i);
            
            result_sum = result_sum + ((U(j,i) * log(ml2_Pji(theta_j,a_i,b_i,D))) + ((1 - U(j,i)) * log(ml2_Qji(theta_j,a_i,b_i,D))));
        end
        result(j) = result_sum;
    end

end

