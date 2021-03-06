% program 
% D1_dyn_ND_T_with_prod_implicit_euler_dr
% problem: dT/dt = a*d^2T/dx^2+s(x),  0<=x<=Len
% for x = 0, -k*dT/dx=q0                (boundary condition Neumann)
% for x = Len, T = TL                   (boundary condition Dirichlet)
% for t = 0, T = 0                      (initial condition)
% s(x) = 10exp(-5x^2/Len^2)
% Implicit Euler

clear; clc;
% data of problem
%ro     =   1.0;        % density
%cp     =   1.0;        % specific heat capacity
k      =   1.0;        % thermal conductivity
Len    =   5.0;        % length
q0     =   3.0;        % heat flow at left end    (x = 0)
TL     =   0.0;        % temperature at right end (x = Len)

% data of problem w.r.t. time
t_max  =  20.0;        % max time
dt     =   0.1;        % time step
tnodes = 1 + t_max/dt; % number of time nodes

% data for solution with FEM
nel    = 10;           % number of elements       
npe    =  2;           % number of nodes per element
nnodes = nel + 1;      % total number of nodes

Z      = zeros(nel,npe);          % connectivity matrix
A      = zeros(2,2);              % local Laplacian matrix
B      = zeros(2,2);              % local mass matrix 
L      = zeros(nnodes,nnodes);    % global Laplacian matrix
M      = zeros(nnodes,nnodes);    % global mass matrix
c      = zeros(nnodes,1);         % vector created by Neumann conditions

x      = zeros(nnodes,1);         % x-coordinate of nodes
T      = zeros(nnodes,tnodes);    % solution matrix w.r.t. x and t 
s      = zeros(nnodes,1);         % vector that shows the heat production
                                  % at all nodes
Ag     = zeros(nnodes,nnodes);    % global matrix of system 
bg     = zeros(nnodes,1     );    % global vector of system 

b      = zeros(nnodes,1     );    %  

dx     = Len/nel;                 % length of each element 

A      = 1/dx*[+1, -1;-1, +1];    % local Laplacian matrix
B      = dx/6*[+2, +1;+1, +2];    % local mass matrix

% computation of vector x
for i = 1:nel
    x(i,1) = (i-1)*dx;
end
x(nnodes,1) = Len;

% computation of vector s
s = 10*exp(-5*x.^2/Len^2);

% Evaluation of matrix Z
for ie = 1:nel                  % index for element
    for i = 1:npe               % index for local numbering
        Z(ie,i) = ie + i - 1;   % connectivity matrix
                                % global numbering of a node that belongs
                                % to element ie and has local index i
    end
end

% Evaluation of matrices L and M
for ie = 1:nel                  % index for element
    for i = 1:npe               % index for local numbering
        ig = Z(ie,i);           % global numbering of a node that belongs
                                % to element ie and has local index i 
        for j = 1:npe           % index for local numbering
            jg = Z(ie,j);       % global numbering of a node that belongs
                                % to element ie and has local index j 
            L(ig,jg) = L(ig,jg) + A(i,j); % contribution of local 
                                          % Laplacian matrix 
            M(ig,jg) = M(ig,jg) + B(i,j); % contribution of local 
                                          % mass matrix 
        end
    end
end

% Evaluation of vector c
c(1,1) = q0;

% Evaluation of vector b
b = M*s + c;

% Initial condition
T(:,1) = zeros(nnodes,1); 

% Implicit Euler
M_new  = M;
L_new  = k*L;
Ag     = M_new + dt*L_new;
% Apply Dirichlet condition on right end
Ag(nnodes,:)      = zeros(1,nnodes); % set zero to all elements of last row
Ag(nnodes,nnodes) = 1.0;             % set Ag(nnodes,nnodes) = 1
for i_time = 2:tnodes
    bg = M_new*T(:,i_time-1) + dt*b;
    % Apply Dirichlet condition on right end
    bg(nnodes,1) = TL;
    T (:,i_time) = Ag\bg;
end

figure(1)
hold on
for i_time = 1:5:tnodes
    plot(x,T(:,i_time),'-o')
    axis([0 Len 0 140])         % keeps y axis fixed
    xlabel('x')                 % title of x axis
    ylabel('temperature')       % title of y axis
    pause(0.1)                  % sets time distance between two figures
end
