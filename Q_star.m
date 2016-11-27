function result = Q_star( theta,a,b,D )
%Q_STAR Logit function ML2 (1 - P_star)
%   Q_star = @(theta,a,b,D) 1 - P_star(theta,a,b,D);

    result = 1 - P_star(theta,a,b,D);
end

