function [integral] = int_D1_Gauss_Legendre_1(a,b)
prod = 1;
if (a==b)
    integral = 0;
    return
end

if a > b
    prod = -1;
    c = b;
    b = a;
    a = c;
end

n = 7;
[t,w] = gauss_legendre(n);

integral = (b-a)/2*w'*fun_h(t,a,b)*prod;

return
               

