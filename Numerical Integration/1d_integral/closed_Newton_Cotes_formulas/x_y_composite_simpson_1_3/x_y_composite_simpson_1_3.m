function [ integral ] = x_y_composite_simpson_1_3( x, y )
N_plus_1_x  = length(x);
N_plus_1_y  = length(y);

if N_plus_1_x ~= N_plus_1_y
    integral = []
    return
else
    N = N_plus_1_x - 1;
    N_2 = N/2;
    if isinteger(N_2)
        integral = 0;
        for i = 1:N_2
            x1 = x((i-1)*2 + 1,1);
            x2 = x((i-1)*2 + 2,1);
            x3 = x((i-1)*2 + 3,1);
            y1 = y((i-1)*2 + 1,1);
            y2 = y((i-1)*2 + 2,1);
            y3 = y((i-1)*2 + 3,1);
            [ a,b,c,integral_new ] = abc_fun( x1,x2,x3,y1,y2,y3 );
            integral = integral + integral_new;
        end
    else
        N_2 = (N-1)/2;
        integral = 0;
        for i = 1:N_2
            x1 = x((i-1)*2 + 1,1);
            x2 = x((i-1)*2 + 2,1);
            x3 = x((i-1)*2 + 3,1);
            y1 = y((i-1)*2 + 1,1);
            y2 = y((i-1)*2 + 2,1);
            y3 = y((i-1)*2 + 3,1);
            [ a,b,c,integral_new ] = abc_fun( x1,x2,x3,y1,y2,y3 );
            integral = integral + integral_new;
        end 
        integral = integral + (y(N,1)+y(N+1,1))/2*(x(N+1,1)-x(N,1));
    end
end
return