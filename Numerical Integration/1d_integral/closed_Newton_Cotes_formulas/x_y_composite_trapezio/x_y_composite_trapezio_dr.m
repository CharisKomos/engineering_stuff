% x_y_composite_simpson_1_3_dr
% N: number of data
% N-1: number of intervals
% if (N-1) is even, we have (N-1)/2 triplets
% if (N-1) is odd, we have (N-2)/2 triplets and one dyad
clear; clc;

a  = 0;
b  = 2*pi;
N  = 14;
x  = rand(N,1);
x  = [0;x;1];
x  = sort(x);
x  = (b-a)*x;

N  = N + 2 % N-1 is odd
pause

y  = x_y_fun(x);
x_y_data = [x, y]
pause

format long
% exact_integral = integral(@x_y_fun,a,b)
exact_integral = 0
pause

[ numerical_integral ] = x_y_composite_trapezio( x, y )
pause

error = abs(exact_integral - numerical_integral)

