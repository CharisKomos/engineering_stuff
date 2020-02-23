function plot_3_master(ne,ng,p,c,f)

%=============================================
% Color mapped visualization of a function f
% in a domain discretized into 3-node triangles
%=============================================

% compute the maximim and minimum of the function f

fmin =   100.0;
fmax = - 100.0;

for i = 1:ng
    if (f(i,1) > fmax) fmax = f(i,1); end
    if (f(i,1) < fmin) fmin = f(i,1); end
end

range = 1.2*(fmax-fmin);
shift = fmin;

% shift the color index in the range (0, 1)
% and plot 4-point patches

for l = 1:ne
    
    j       = c(l,1); 
    xp(1,1) = p(j,1); 
    yp(1,1) = p(j,2); 
    cp(1,1) = (f(j,1) - shift) / range;
   
    j       = c(l,2); 
    xp(2,1) = p(j,1); 
    yp(2,1) = p(j,2); 
    cp(2,1) = (f(j,1) - shift) / range;
    
    j       = c(l,3); 
    xp(3,1) = p(j,1); 
    yp(3,1) = p(j,2); 
    cp(3,1) = (f(j,1) - shift) / range;
    
    j       = c(l,1); 
    xp(4,1) = p(j,1); 
    yp(4,1) = p(j,2); 
    cp(4,1) = (f(j,1) - shift) / range;
    
    patch(xp,yp,cp); hold on;
    
end

%----------------------
% define the axes range
%----------------------
 
xlabel('x','fontsize',15);
ylabel('y','fontsize',15);
zlabel('f','fontsize',15);
set(gca,'fontsize',15)

return
