function Y = fill_responses( theta, a, b, c, D )
%FILL_ Summary of this function goes here
%   Detailed explanation goes here

    N = size(theta,2); % N = students awnsers set (j = 1, ..., N)
    I = size(b,2); % I = item set (i = 1, ..., I)

    Y = [];

    for j=1:N

        for i=1:I
            theta_j = theta(1,j);
            a_i = a(1,i);
            b_i = b(1,i);
            c_i = c(1,i);
                        
            P = Pji(theta_j, a_i, b_i, c_i, D);

            if(P > rand(1,1))
            %if(P > 0.75)
                y = 1;
            else
                y = 0;
            end

            Y(j, i) = y;

        end
    end
end
