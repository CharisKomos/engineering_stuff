% x_y_composite_simpson_1_3_dr
clear; clc;

a  = 0;
b  = 2*pi;
N  = 13;
x  = rand(N,1);
x  = [0;x;1];
x  = sort(x);
x  = (b-a)*x;

N  = N + 2
pause

y  = x_y_fun(x);
x_y_data = [x, y]
pause

format long
% exact_integral = integral(@x_y_fun,a,b)
exact_integral = 0
pause

[ numerical_integral ] = x_y_composite_simpson_1_3( x, y )
pause

error = abs(exact_integral - numerical_integral)

