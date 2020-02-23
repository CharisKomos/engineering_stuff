function [ y ] = fun( x )
y = 2000*log(140000./(140000-2100*x))-9.8*x;
return