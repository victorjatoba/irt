% Manipulating variables expressions

syms x
f = 3*x^2+5*x-3;
g = 2*x+1;

df = diff(f); %derivative

Total = df;
disp(df);

