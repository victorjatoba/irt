function result = derivative_a( Y,theta,a,b,c,D )
%DERIVATIVE_A Derivative of discrimination parameter
%   derivative_a = @(theta,a,b,c,D) D.* (1-c).* (theta - b).* P_star(theta,a,b,D).* Q_star(theta,a,b,D);

    result = D.* (1-c).* sum((Y-Pji(theta,a,b,c,D)).* (theta-b).* Wji(theta,a,b,c,D));
end

