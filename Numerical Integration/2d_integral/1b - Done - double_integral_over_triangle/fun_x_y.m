function [f] = fun_x_y(x,y)
f = x.^2 + x.*y - y.^2;%1./sqrt(x+y)./(1+x+y).^2;
return
