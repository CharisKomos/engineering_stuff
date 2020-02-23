% Script for anlytical solution for 2.2

clear; clc;




[X,T] = meshgrid(0:0.1:5,0:1:50);
 
 Z_Anal = qwer_2_2_test(X,T);
 
 figure(1)
 surf(X,T,Z_Anal)


