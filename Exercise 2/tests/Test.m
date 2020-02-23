% 2.1 Anal Solution 
% B. Cond du(0,t)/dx = 0 , u(2,t) = 0 t>0
% initial condition u(x,0) = 10

%t = 0 ; 
%x = 1 ; 
 clear ; clc;


%x = 0:0.1:2 ; 
n=[1:40];
x=0:0.1:2;
t = 0:1:10 ;

[N,X,T] = meshgrid(n,x,t);
sys = @(n,x,t) (40/((2.*n-1).*pi)).*sin((2.*n-1).*pi/2).*cos((2.*n-1)*pi.*x/4).*exp(-4.*n.^2.*t);
sys_sum = sum(sys(N,X,T));

FF = reshape(sys_sum,1,40,11);

plot(X,T)

 %{

 [X,T] = meshgrid(0:0.1:2,0:1:10)
 
 Z_Anal = fun_x_t(X,T)
 
 figure(1)
 surf(X,T,Z_Anal)
 %}
    
