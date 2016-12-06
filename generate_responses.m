function U = generate_responses( Num_prove_responses, theta, a, b, c, D )
%FILL_ Summary of this function goes here
%   Detailed explanation goes here

    I = size(b,2); % I = item set (i = 1, ..., I)

    U = [];

    for j=1:Num_prove_responses
        for i=1:I
            a_i = a(1,i);
            b_i = b(1,i);
            c_i = c(1,i);
                        
            P = Pji(theta, a_i, b_i, c_i, D);

            if(P > rand(1,1))
                y = 1;
            else
                y = 0;
            end

            U(j, i) = y;

        end
    end
end
