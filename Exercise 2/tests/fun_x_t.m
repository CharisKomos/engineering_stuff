function [z] = fun_x_t( x, t )

z=0;
 
for i = 1:40
    u = (40/((2*i-1)*pi))*sin((2*i-1)*pi/2)*cos((2*i-1)*pi*x/4)*exp(-4*i^2.*t);
    z = z + u 
    pause(0.1)
end
return
end

