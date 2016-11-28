function result = derivative_a( Y,theta,a,b,c,D )
%DERIVATIVE_A Derivative of discrimination parameter (Reff.: Andrade, 3.14)
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, b, c, D: items parameters

    result = D.* (1-c).* sum((Y-Pji(theta,a,b,c,D)).* (theta-b).* Wji(theta,a,b,c,D));
end

