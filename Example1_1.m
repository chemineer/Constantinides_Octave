% Examplel_l.m
% This program solves the problem posed in Example 1.1.
% It calculates the friction factor from the Colebrook equation
% using the Sucesive Substitution, the Linear Interpolation,
% and the Newton-Raphson methods.
clear
clc
clf
disp('Calculating the friction factor from the Colebrook equation')
% Input
Re = input('\n Reynolds No. =');
e_over_D = input(' Relative roughnes = ');
method = 1;
while method
fprintf('\n')
disp(' 1 ) Sucesive substitution')
disp(' 2 ) Linear Interpolation')
disp(' 3 ) Newton Raphson')
disp(' 0 ) Exit')
method = input('\n Chose the method of solution :');
if method
fname = input ('\n Function containing the Colebrook equation:');
end
switch method
case 1 % Succesive substitution
x0 = input(' Starting value =');
f = XGX(fname,x0,[],2,Re,e_over_D);
%fprintf('\n f = %6.4f\n',f)
printf('\n f = %f\n',f)
case 2 % Linear interpolation
xl = input('First starting value=');
x2 = input('Second starting value =');
f = LI(fname,xl,x2,[],2,Re,e_over_D);
%fprintf('\n f = %6.4f\n',f)
printf('\n f = %f\n',f)
case 3 % Newton-Raphson
x0 =input('Starting value =');
f =NR(fname,x0,[],2,Re,e_over_D);
%fprintf('\n f = %6.4f\n' ,f)
printf('\n f = %f\n',f)
end
end
