function [ a,b,c,integral ] = abc_fun( x1,x2,x3,y1,y2,y3 )
A = [x1^2, x1, 1; x2^2, x2, 1; x3^2, x3, 1];
y = [y1;y2;y3];
z = A\y;
a = z(1,1);
b = z(2,1);
c = z(3,1);
integral = a/3*(x3^3-x1^3) + b/2*(x3^2-x1^2) + c*(x3-x1);
return

