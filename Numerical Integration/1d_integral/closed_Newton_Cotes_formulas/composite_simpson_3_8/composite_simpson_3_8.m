function [ integral ] = composite_simpson_3_8( fun,a,b,N )
h          = (b-a)/N/3;
x1         = [(a+1*h):3*h:(b-2*h)].';
x2         = [(a+2*h):3*h:(b-1*h)].';
x3         = [(a+3*h):3*h:(b-3*h)].';
integral_1 = 3*sum(fun(x1));
integral_2 = 3*sum(fun(x2));
integral_3 = 2*sum(fun(x3));
integral   = integral_1 + integral_2 + integral_3 + fun(a) + fun(b);
integral   = 3/8*h*integral;
return