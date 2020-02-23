% program 
% based on D1_ss_DN_T_convection_dr_02 
% problem: Pe*dc/dz = d^2c/dz^2-Da*exp(-bT)*c,  0<=z<=1
% for z = 0, c = 1                      (boundary condition Dirichlet)
% for z = 1, dc/dz = 0                  (boundary condition Neumann)


function [c] =Askisi_2_3_b_par(T,Pe)

% data of problem
Len    =   1.0;          
Da     =   1000;
b      =   10;
c0     =   1.0;        % concentration at left  end (z = 0)
dc     =   0.0;        % flow at right end   (z = 1)


% data for solution with FEM
nel    = 20;           % number of elements       
npe    =  2;           % number of nodes per element
nnodes = nel + 1;      % total number of nodes

Z      = zeros(nel,npe);          % connectivity matrix
A      = zeros(2,2);              % local Laplacian matrix
B      = zeros(2,2);              % local mass matrix 
C      = zeros(2,2);              % local advection matrix

z      = zeros(nnodes,1);         % x-coordinate of nodes 
c      = zeros(nnodes,3);

AG     = zeros(nnodes,nnodes);    % global matrix A
bG     = zeros(nnodes,1);         % global vector b

dz     = Len/nel;                 % length of each element 

A      = 1/dz*[+1, -1;-1, +1];    % local Laplacian matrix
B      = dz/6*[+2, +1;+1, +2];    % local mass matrix
C      = 1/2* [-1, +1;-1, +1];    % local advection matrix

% computation of vector x
for i = 1:nel
    z(i,1) = (i-1)*dz;
end
z(nnodes,1) = Len;

% Evaluation of matrix Z
for ie = 1:nel                  % index for element
    for i = 1:npe               % index for local numbering
        Z(ie,i) = ie + i - 1;   % connectivity matrix
                                % global numbering of a node that belongs
                                % to element ie and has local index i
    end
end

% Evaluation of matrix AG
for ie = 1:nel                  % index for element
    for i = 1:npe               % index for local numbering
        i1 = Z(ie,i);           % global numbering of a node that belongs
                                % to element ie and has local index i 
        for j = 1:npe           % index for local numbering
            j1 = Z(ie,j);       % global numbering of a node that belongs
                                % to element ie and has local index j 
            AG(i1,j1) = AG(i1,j1) + Pe*C(i,j) + ...
                                       A(i,j) + ...
                                    Da*exp(-b*T(ie))*B(i,j);  
        end
    end
end

% application of Dirichlet condition at left end
AG(1,:) = zeros(1,nnodes);
AG(1,1) = 1;
bG(1,1) = c0;

% solution of system
c      = AG\bG;
  
  
return