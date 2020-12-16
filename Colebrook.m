function y = Colebrook(f, Re, e)
% Colebrook.m
% This function evaluates the value of Colebrook equation to be
% solved by the linear interpolation or the Nowton-Raphson method.
y = 1/sqrt(f) + 0.86*log(e/3.7 + 2.51/Re/sqrt(f));