function logit = Qji( theta, a, b, c, D )
%QJI Logit function ML3 (1 - P)
%   Qji = @(theta,a,b,c,D) 1 - Pji(theta,a,b,c,D);

    logit = 1 - Pji(theta,a,b,c,D);

end

