function [ integral ] = composite_trapezio( fun,a,b,N )
h        = (b-a)/N;
x        = [a:h:b].';
integral = 2*sum(fun(x(2:N,1)));
integral = integral + fun(a) + fun(b);
integral = h/2*integral;
return