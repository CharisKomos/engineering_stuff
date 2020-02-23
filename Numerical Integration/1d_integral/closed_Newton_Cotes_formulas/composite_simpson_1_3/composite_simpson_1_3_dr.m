% composite_simpson_1_3_dr
clear; clc;

a  = 8;
b  = 30;
N1 =  1; n1 = 2*N1;
N2 =  5; n2 = 2*N2;
N3 = 10; n3 = 2*N3;
N4 = 20; n4 = 2*N4;
N5 = 40; n5 = 2*N5;

format long
% exact_integral = integral(@fun,8,30)
exact_integral = 1.106133553508099e+04
pause

[ numerical_integral_1 ] = composite_simpson_1_3( @fun,a,b,N1 )
[ numerical_integral_2 ] = composite_simpson_1_3( @fun,a,b,N2 )
[ numerical_integral_3 ] = composite_simpson_1_3( @fun,a,b,N3 )
[ numerical_integral_4 ] = composite_simpson_1_3( @fun,a,b,N4 )
[ numerical_integral_5 ] = composite_simpson_1_3( @fun,a,b,N5 )
pause

error_1 = abs(exact_integral - numerical_integral_1)
error_2 = abs(exact_integral - numerical_integral_2)
error_3 = abs(exact_integral - numerical_integral_3)
error_4 = abs(exact_integral - numerical_integral_4)
error_5 = abs(exact_integral - numerical_integral_5)
pause

relative_error_1 = abs((exact_integral - numerical_integral_1)/...
                        exact_integral)*100
relative_error_2 = abs((exact_integral - numerical_integral_2)/...
                        exact_integral)*100
relative_error_3 = abs((exact_integral - numerical_integral_3)/...
                        exact_integral)*100
relative_error_4 = abs((exact_integral - numerical_integral_4)/...
                        exact_integral)*100
relative_error_5 = abs((exact_integral - numerical_integral_5)/...
                        exact_integral)*100
pause

figure(1)
plot(log10([n1, n2, n3, n4, n5]),...
     log10([error_1, error_2, error_3, error_4, error_5]),'o')

