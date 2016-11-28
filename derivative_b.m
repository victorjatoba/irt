function result = derivative_b( Y, theta,a,b,c,D )
%DERIVATIVE_B Derivative of difficult parameter (Reff.: Andrade 3.15)
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, b, c, D: items parameters

    result = -D.* a.* (1-c).* sum((Y - Pji(theta,a,b,c,D)).* Wji(theta,a,b,c,D));
end

