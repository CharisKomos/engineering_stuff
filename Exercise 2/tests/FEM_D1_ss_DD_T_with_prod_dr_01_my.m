% program 
% FEM_D1_ss_DD_T_with_prod_dr_01
% problem: r*Cp*dT/dt = k*d^2T(x)/dx^2+s(x),  0<=x<=Len
% for x = 0,   -k*dT/dx = q0    (boundary condition Neumann)
% for x = Len, T = TL           (boundary condition Dirichlet)
% s(x) = 10exp(-5x^2/Len^2)
% explicit Euler

clear; clc;
% data of problem
ro     =   0.5;
cp     =   0.5;
k      =   1.0;
Len    =   2.0;
q0     =   0.0;
TL     =   0.0;

t_max  = 20.0;
dt     = 0.0004;
tnodes = 1 + t_max/dt;


 
% data for solution with FEM
nel    = 20;                    % number of elements
npe    = 2;                    % number of nodes per element
nnodes = nel + 1;              % number of nodes
A      = zeros(2,2);           % local Laplace matrix
B      = zeros(2,2);           % local Mass    matrix
Ag     = zeros(nnodes,nnodes); % global matrix of system
bg     = zeros(nnodes,1);      % global vector of system
L      = zeros(nnodes,nnodes); % global Laplace matrix
M      = zeros(nnodes,nnodes); % global Mass matrix
Z      = zeros(nel,npe);       % connectivity matrix
c      = zeros(nnodes,1);      % vector of contribution of Neumann 
                               % boundary conditions 

x      = zeros(nnodes,1);    % vector of x-coordinates of all nodes
T      = zeros(nnodes,tnodes);    % vector of unknown temperatures at all nodes
s      = zeros(nnodes,1);    % vector of production at all nodes

dx     = Len/nel;            % constant length of all finite elements

A      = 1/dx*[+1, -1;-1, +1]; % local Laplace matrix         
B      = dx/6*[+2, +1;+1, +2]; % local Mass    matrix

% Evaluation of vector x of x-coordinates of all nodes
for i = 1:nel
    x(i,1) = (i-1)*dx;
end
x(nnodes,1) = Len;

% Evaluation of vector s of production at all nodes
%s = 10*exp(-5*x.^2/Len^2);

% Evaluation of connectivity matrix Z
for ie = 1:nel
    for i = 1:npe
        Z(ie,i) = ie + i -1;
    end
end

% Evaluation of matrices Ag and M
for ie = 1:nel
    for i = 1:npe
        ig = Z(ie,i);
        for j = 1:npe
            jg = Z(ie,j);
            L(ig,jg) = L(ig,jg) + A(i,j);
            M(ig,jg) = M(ig,jg) + B(i,j);
        end
    end
end

% Evaluation vector c
c(1,1) = q0;

% Evaluation vector b
b = zeros(nnodes,1) + c;

T(:,1) = 10*ones(nnodes,1);

M_new = ro*cp*M;
L_new = k*L;
Ag = M_new;

Ag(nnodes,:) = zeros(1,nnodes);
Ag(nnodes,nnodes) = 1.0;

for i_time = 2:tnodes
    bg = M_new*T(:,i_time-1) + dt*(b-L_new*T(:,i_time-1));
    bg(nnodes,1)   = TL;
    T(:,i_time)    = Ag\bg;
end


figure(1)
hold on
for i_time = 1:1000:tnodes
    plot(x,T(:,i_time),'-o')
    axis([0 Len -2 12])
    xlabel('x')
    ylabel('Temperature')
    pause(0.2)
end
