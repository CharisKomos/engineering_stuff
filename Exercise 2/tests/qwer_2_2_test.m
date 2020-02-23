function [z] =  qwer_2_2_test( x , t)

a = 1;
omega = 2;
k = sqrt(omega/2*a);

z = (exp(-k*x)).*(cos(omega*t-k*x));

end