function logistic_deviation = L( theta,a,b,D )
%L Logistic deviation Function
%   L = @(theta,a,b,D) D.*a.*(theta-b);

    logistic_deviation = D.*a.*(theta-b);

end

