function ml2 = P_star( theta,a,b,D )
%P_STAR Logit function ML2
%   P_star = @(theta,a,b,D) 1./(1 + exp(-L(theta,a,b,D)));

    ml2 = 1./(1 + exp(-L(theta,a,b,D)));

end

