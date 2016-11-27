function result = Wji( theta,a,b,c,D )
%WJI Ponderated value [Eq. 3.5]
%   Wji = @(theta,a,b,c,D) (P_star(theta,a,b,D).*Q_star(theta,a,b,D))./ (Pji(theta,a,b,c,D).*Qji(theta,a,b,c,D));
    
    result = (P_star(theta,a,b,D).*Q_star(theta,a,b,D))./ (Pji(theta,a,b,c,D).*Qji(theta,a,b,c,D));

end

