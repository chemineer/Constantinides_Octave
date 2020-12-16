function y = clbrkg(f, Re, e)
% Colebrookg.m
% This function evaluates the value of the rearranged Colebrook
% equation to be solved by x=g(x) method.
y=1/(0.86*log(e/3.7+2.51/Re/sqrt(f)))^2;