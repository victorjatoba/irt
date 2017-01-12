function logit = ml2_Qji( theta, a, b, D )
%QJI Logit function ML3 (1 - P)
%   Qji = @(theta,a,b,c,D) 1 - Pji(theta,a,b,c,D);

    logit = 1 - ml2_Pji(theta,a,b,D);

end

