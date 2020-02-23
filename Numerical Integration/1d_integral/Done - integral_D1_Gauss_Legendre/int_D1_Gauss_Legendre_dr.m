% program 
% int_D1_Gauss_Legendre_dr
clear; clc;
% integral of f(x) = sin(x) 
% between 0 and 3.1415
% for different N

a = 0;
b = pi;

N  = 7;
%pause

format long
exact_integral = integral(@fun_f,a,b);
%exact_integral = 1.106133553508099e+04
%pause

[ numerical_integral ] = int_D1_Gauss_Legendre(a,b,N);
%pause

error = abs(exact_integral - numerical_integral);
%pause

relative_error = abs((exact_integral - numerical_integral)/exact_integral)*100;

