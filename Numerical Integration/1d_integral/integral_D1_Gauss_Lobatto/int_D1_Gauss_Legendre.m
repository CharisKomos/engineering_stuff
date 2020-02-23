function [integral] = int_D1_Gauss_Legendre(a,b,N)
prod     = 1;
integral = 0;
if a==b
    integral = 0;
    return
end
if a > b
    prod = -1;
    c = b;
    b = a;
    a = c;
end
dx = (b-a)/N;
xx = zeros(N+1,1);
for i = 1:N
    xx(i,1) = a + (i-1)*dx;
end
xx(N+1,1) = b;
for i = 1:N
    integral = integral + int_D1_Gauss_Legendre_1(xx(i,1),xx(i+1,1));
end

integral = integral*prod;

return
               

