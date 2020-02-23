function [emm, A] = emm3_master(x1,y1,x2,y2,x3,y3)

%======================================
% Evaluation of the element mass matrix
% from the coordinates of the three
% vertices of a 3-node triangle.
%======================================

emm = zeros(3);

d23x = x2-x3; 
d23y = y2-y3;
 
d31x = x3-x1; 
d31y = y3-y1;
 
d12x = x1-x2; 
d12y = y1-y2;

A    = 0.5*(d31x*d12y - d31y*d12x);
fc   = A/12;

emm  = fc*[2,1,1;1,2,1;1,1,2];

return
