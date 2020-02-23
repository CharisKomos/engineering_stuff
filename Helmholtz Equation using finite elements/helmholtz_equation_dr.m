% Solution of Helmholtz equation
% at rectangle area drawn by 0<=x<=10 and 0<=y<=5

% Data
k     = 5.0;        % Conductivity coefficient
alpha = 3.0;        % helmoholtz coefficient
ndiv  = 3;          % Level of triangulation

% Triangulation
[ne,ng,p,c,efl,gfl] = triangulation_3_nodes(ndiv);

% Neumann boundary condition for the whole perimeter of rectangle
for i = 1:ng
	if(gfl(i,1) == 1)
		gfl(i,2) = 7; % q(l) = 7 (Given)
	end
end

% Assemblance of the global Diffusion and Mass matrix

gdm = zeros(ng,ng);
gmm = zeros(ng,ng);

for k = 1:ne
	% Computation of the elements' matrices
	j  = c(k,1);
	x1 = p(j,1);
	y1 = p(j,2);
	
	j  = c(k,2);
	x2 = p(j,1);
	y2 = p(j,2);
	
	j  = c(k,3);
	x3 = p(j,1);
	y3 = p(j,2);
	
	[edm_elm] = edm3(x1,y1,x2,y2,x3,y3);
	[emm_elm] = emm3(x1,y1,x2,y2,x3,y3);
	
	for l = 1:3
		l1 = c(k,l);
		for j = 1:3
			j1 = c(k,j);
			gdm(l1,j1) = gdm(l1,j1) + edm_elm(l,j);
			gmm(l1,j1) = gmm(l1,j1) + emm_elm(l,j);
		end
	end
end

% Set up the right-hand side
b = zeros(ng,1);

% Neumann application on the right hand-side
for i = 1:ne
	efl(i,4) = efl(i,1);	% Replication of the first node
	c(i,4)   = c(i,1);		% 				>>
	
	for j = 1:3
		 if(efl(i,j) == 1 & efl(i,j+1) == 1)
			j1 = c(i,j);
			j2 = c(i,j+1);
			
			xe1 = p(j1,1);
			ye1 = p(j1,2);
			
			xe2 = p(j2,1);
			ye2 = p(j2,2);
			
			edge = sqrt( (xe2-xe1)^2 + (ye2-ye1)^2 );
			
			int1 = edge*( gfl(j1,2)/3 + gfl(j2,2)/6 );
			int2 = edge*( gfl(j1,2)/6 + gfl(j2,2)/3 );
			
			b(j1,1) = b(j1,1) + int1/k;
			b(j2,1) = b(j2,1) + int2/k;
		 end
	end
end

% Coefficient matrix
lsm = gdm - alpha*gmm;

% Solve the linear system
f = lsm\b;

% Plot

figure(1)
color_map_vis(ne,ng,p,c,f);

figure(2)
trimesh(c,p(:,1),p(:,2),f);


figure(3)
trisurf(c,p(:,1),p(:,2),f,f);
