function [y] = fun_h(t,a,b)
x = fun_q(t,a,b);
y = fun_f(x);
return