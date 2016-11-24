function logito_result = logito( x )
%LOGITO The Logit function
%   Detailed explanation goes here

    logito_result = exp(x)./(1 + exp(x));
end