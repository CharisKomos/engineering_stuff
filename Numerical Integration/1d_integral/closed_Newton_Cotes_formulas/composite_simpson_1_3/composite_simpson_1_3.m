function [ integral ] = composite_simpson_1_3( fun,a,b,N )
h          = (b-a)/N/2;
x1         = [(a+1*h):2*h:(b-1*h)].';
x2         = [(a+2*h):2*h:(b-2*h)].';
integral_1 = 4*sum(fun(x1));
integral_2 = 2*sum(fun(x2));
integral   = integral_1 + integral_2 + fun(a) + fun(b);
integral   = h/3*integral;
return