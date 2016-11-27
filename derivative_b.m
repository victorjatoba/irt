function result = derivative_b( theta,a,b,c,D )
%DERIVATIVE_B Derivative of difficult parameter
%   derivative_b = @(theta,a,b,c,D) -D.* a.* (1-c).* P_star(theta,a,b,D).* Q_star(theta,a,b,D);


    result = -D.* a.* (1-c).* P_star(theta,a,b,D).* Q_star(theta,a,b,D);

end

