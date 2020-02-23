% program 
% int_D2_Gauss_triangle_dr
clear; clc;
% integral of f(x,y) = x^2 + x*y - y^2
% over a triangle with vertices (x1,y1), (x2,y2), (x3,y3)
% for 0=x<=1 and 0<=y<=1
x1 = 1; y1 = 2;
x2 = 2; y2 = 1;
x3 = 3; y3 = 2;
x4 = 2; y4 = 4;

% For 4 points in each dimension
N  = 4;

format long
[integral1]          = int_D2_Gauss_triangle(x1,y1,x2,y2,x4,y4,N);
[integral2]          = int_D2_Gauss_triangle(x2,y2,x3,y3,x4,y4,N);

result = integral1 + integral2

% Analytical Integral
%analytical_integral = pi/4-1/2

% Error between analytical and numerical
%error               = abs(integral - analytical_integral)

