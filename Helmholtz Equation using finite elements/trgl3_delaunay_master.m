function [ne,ng,p,c,efl,gfl] = trgl3_delaunay_master()
%======================================
% Discretization of an arbitrary domain
% into 3-node triangular elements
% by the Delaunay triangulation
%======================================
%----------------------------------------
% Read the global nodes
% and boundary flags from file: points.dat
% The three columns in this file are the
% x and y coordinates and the boundary flag
% of the global nodes:
% x(1) y(1) gfl(1)
% x(2) y(2) gfl(2)
% ... ... ...
% x(n) y(n) gfl(n)
%----------------------------------------
file1 = fopen('points.dat');
points = fscanf(file1,'%f');
fclose(file1);
%---------------------------------------
% number, coordinates, and boundary flag
% of global nodes
%---------------------------------------
sp = size(points);
ng = sp(1,1)/3;
for i = 1:ng
p(i,1)= points(3*i-2,1);
p(i,2)= points(3*i-1,1);
gfl(i,1)= points(3*i,1);
xdel(i,1) = p(i,1);
ydel(i,1) = p(i,2);
end
%-----------------------
% delaunay triangulation
%-----------------------
c = delaunay(xdel,ydel);
%-------------------------------
% extract the number of elements
%-------------------------------
sc = size(c);
ne = sc(1,1);
%------------------------------------
% set the element-node boundary flags
%------------------------------------
for i = 1:ne
efl(i,1) = gfl(c(i,1),1);
efl(i,2) = gfl(c(i,2),1);
efl(i,3) = gfl(c(i,3),1);
end
%-----
% plot
%-----
figure(1)
for i = 1:ne
xp(1,1)= p(c(i,1),1); yp(1,1)= p(c(i,1),2);
xp(2,1)= p(c(i,2),1); yp(2,1)= p(c(i,2),2);
xp(3,1)= p(c(i,3),1); yp(3,1)= p(c(i,3),2);
xp(4,1)= p(c(i,1),1); yp(4,1)= p(c(i,1),2);
plot(xp, yp); hold on
if(efl(i,1)==1) plot(xp(1,1), yp(1,1), 'o'); end;
if(efl(i,2)==1) plot(xp(2,1), yp(2,1), 'o'); end;
if(efl(i,3)==1) plot(xp(3,1), yp(3,1), 'o'); end;
end
xlabel('x','fontsize',15);
ylabel('y','fontsize',15);
set(gca,'fontsize',15)

hold off 
return
 