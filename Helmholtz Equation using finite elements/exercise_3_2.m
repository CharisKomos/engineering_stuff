% Askisi_3_2
% Helmholtz's equation in a 4x6 domain 
% Neumann boundary condition, q(l)=5
 
clear; clc;
 
% data
k= 3.0;
a = 4.0;
ndiv=5; 
 
% triangulate
 
[ne,ng,p,c,efl,gfl] = trgl3_sqr_master(ndiv);

for i = 1:ng
if (gfl(i,1)==1)
gfl(i,2) = 5; 
end
end

% global diffusion and mass matrix

gdm = zeros(ng,ng); % initialize
gmm = zeros(ng,ng); % initialize

for l = 1:ne
% loop over the elements
% compute the element matrices
j = c(l,1);
x1 = p(j,1);
y1 = p(j,2);
j = c(l,2);
x2 = p(j,1);
y2 = p(j,2);
j = c(l,3);
x3 = p(j,1);
y3 = p(j,2);
[edm_elm] = edm3_master(x1,y1,x2,y2,x3,y3);
[emm_elm] = emm3_master(x1,y1,x2,y2,x3,y3);
for i = 1:3
i1 = c(l,i);
for j = 1:3
j1 = c(l,j);
gdm(i1,j1) = gdm(i1,j1) + edm_elm(i,j);
gmm(i1,j1) = gmm(i1,j1) + emm_elm(i,j);
end
end
end
%---------------------------
% set up the right-hand side
%---------------------------
b = zeros(ng,1);
%----------------------------------------
% Neumann integral on the right-hand side
%----------------------------------------

for i = 1:ne
efl(i,4) = efl(i,1);
% replicate the first node
c (i,4) = c(i,1);
% replicate the first node
for j = 1:3
% run around the sides
if ( efl(i,j)==1 && efl(i,j+1)==1 )
j1 = c(i,j);
j2 = c(i,j+1);
 
xe1 = p(j1,1);
ye1 = p(j1,2);
xe2 = p(j2,1);
ye2 = p(j2,2);
edge = sqrt((xe2-xe1)^2+(ye2-ye1)^2);
int1 = edge * ( gfl(j1,2)/3 + gfl(j2,2)/6 );
int2 = edge * ( gfl(j1,2)/6 + gfl(j2,2)/3 );
b(j1,1) = b(j1,1)+int1/k;
b(j2,1) = b(j2,1)+int2/k;
end
end
end
%-------------------
% coefficient matrix
%-------------------
lsm = gdm - a*gmm;
%------------------------
% solve the linear system
%------------------------
f = lsm\b;
 

% plot 
figure(1)
plot_3_master(ne,ng,p,c,f);
  
 
