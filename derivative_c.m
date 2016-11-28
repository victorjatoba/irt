function result = derivative_c( Y, theta,a,b,c,D )
%DERIVATIVE_B Derivative of difficult parameter (Reff.: Andrade 3.15)
%   Y: Set of the users responses
%   theta: The theta value of the user
%   a, b, c, D: items parameters
    
    result = sum((Y - Pji(theta,a,b,c,D)).* (Wji(theta,a,b,c,D) ./ P_star(theta,a,b,D)) );
end

