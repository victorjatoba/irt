% Example of a Logistic Function / Sigmoidal Function
%
% Ref.: https://www.mathworks.com/help/fuzzy/sigmf.html
%
% Author: Victor Jatoba
% Date: 12/10/16

% y = sigmf(x,[a c]);

x = 0:0.1:10;
y = sigmf(x,[2 4]);
plot(x,y)
xlabel('sigmf, P = [2 4]')
ylabel('y');
ylim([-0.05 1.05])