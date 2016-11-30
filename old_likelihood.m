function result = log_likelihood( Y,theta,a,b,c,D )
%LOG_LIKELIHOOD Log likelihood Function
%   log_likelihood = @(Y,theta,a,b,c,D) sum(Y.* log(Pji(theta,a,b,c,D)) + (1 - Y).* log(Qji(theta,a,b,c,D)));

    result = sum(Y.* log(Pji(theta,a,b,c,D)) + (1 - Y).* log(Qji(theta,a,b,c,D)));

end

