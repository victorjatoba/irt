function result = derivative_theta( Y,theta,a,b,c,D )
%DERIVATIVE_THETA Derivative of theta parameter
%   derivative_theta = @(Y,theta,a,b,c,D) D.*sum((a.*(1-c)).* (Y-Pji(theta,a,b,c,D)).*Wji(theta,a,b,c,D));

    result = D.*sum((a.*(1-c)).* (Y-Pji(theta,a,b,c,D)).*Wji(theta,a,b,c,D));

end

