function [ integral ] = x_y_composite_trapezio( x, y )
N_plus_1_x  = length(x)
N_plus_1_y  = length(y)
pause

if N_plus_1_x ~= N_plus_1_y
    integral = []
    return
else
    N = N_plus_1_x - 1;
    h = zeros(N  ,1);
    w = zeros(N+1,1);
    for i = 1:N
        h(i,1) = x(i+1,1) - x(i,1);
    end
    w(1,1) = h(1,1)/2;
    for i = 2:N
        w(i,1) = (h(i-1,1) + h(i,1))/2;
    end
    w(N+1,1) = h(N,1)/2;
    integral = w.'*y;
end

return