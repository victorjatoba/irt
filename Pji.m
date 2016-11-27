function logit = Pji( theta,a,b,c,D )
%PJI Logit function ML3
%   Pji = @(theta,a,b,c,D) c + (1 - c).* 1./(1 + exp(-L(theta,a,b,D)));

    logit = c + (1 - c).* 1./(1 + exp(-L(theta,a,b,D)));

end

