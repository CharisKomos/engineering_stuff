% MATLAB_integration_dr
clear; clc;

a  = 8;
b  = 30;

format long
% exact_integral = integral(@fun,8,30)
exact_integral = 1.106133553508099e+04
pause

[ numerical_integral_1 ] = quad( @fun,a,b )
[ numerical_integral_2 ] = quadl( @fun,a,b )
[ numerical_integral_3 ] = quadgk( @fun,a,b )
pause

error_1 = abs(exact_integral - numerical_integral_1)
error_2 = abs(exact_integral - numerical_integral_2)
error_3 = abs(exact_integral - numerical_integral_3)
pause

relative_error_1 = abs((exact_integral - numerical_integral_1)/...
                        exact_integral)*100
relative_error_2 = abs((exact_integral - numerical_integral_2)/...
                        exact_integral)*100
relative_error_3 = abs((exact_integral - numerical_integral_3)/...
                        exact_integral)*100

