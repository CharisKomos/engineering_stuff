% program 
% based on D1_ss_DN_T_convection_dr_02 
% problem: Pe*dT/dz = d^2T/dz^2-Bi*T,  0<=z<=1
% for z = 0, T = 1            (boundary condition Dirichlet)
% for z = 1, dT/dz = 0        (boundary condition Neumann)
5
clear; clc;
 

% data of problem
Len    =   1.0;           
Pe     =   [10 50 100];
Bi     =   100.0;      %  
T0     =   1.0;        % temperature at left  end (x = 0)
qL     =   0.0;        % heat flow at right end   (x = 1)

% data for solution with FEM
nel    = 20;           % number of elements       
npe    =  2;           % number of nodes per element
nnodes = nel + 1;      % total number of nodes

Z      = zeros(nel,npe);          % connectivity matrix
A      = zeros(2,2);              % local Laplacian matrix
B      = zeros(2,2);              % local mass matrix 
C      = zeros(2,2);              % local advection matrix


z      = zeros(nnodes,1);         % x-coordinate of nodes
T      = zeros(nnodes,3);         % solution vector w.r.t. x  
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

% part 1

for k=1:3
 
% Evaluation of matrix AG
for ie = 1:nel                  % index for element
    for i = 1:npe               % index for local numbering
        i1 = Z(ie,i);           % global numbering of a node that belongs
                                % to element ie and has local index i 
        for j = 1:npe           % index for local numbering
            j1 = Z(ie,j);       % global numbering of a node that belongs
                                % to element ie and has local index j 
            AG(i1,j1) = AG(i1,j1) + Pe(k)*C(i,j) + ...
                                       A(i,j) + ...
                                    Bi*B(i,j);  
        end
    end
end

% application of Dirichlet condition at left end
AG(1,:) = zeros(1,nnodes);
AG(1,1) = 1;
bG(1,1) = T0;

% solution of system
T(:,k)  = AG\bG ; 
 
 
 [c(:,k)] =Askisi_2_3_b_par(T(:,k),Pe(k));
 
end 
  
subplot(2,1,1)
plot(z,T(:,1),'k',z,T(:,2),'r',z,T(:,3),'b')
axis([0 Len 0.0 1.1])           
xlabel('z')                   % title of z axis
ylabel('temperature')         % title of y axis
 
subplot(2,1,2)
plot(z,c(:,1),'k',z,c(:,2),'r',z,c(:,3),'b')
axis([0 Len 0.0 1.1])           
xlabel('z')                   % title of z axis
ylabel('concentration')       % title of y axis
 

% part 2
 
Pe     =   [10:10:200];
T      = zeros(nnodes,20);         
c      = zeros(nnodes,20); 

for k=1:20
 
% Evaluation of matrix AG
for ie = 1:nel                  % index for element
    for i = 1:npe               % index for local numbering
        i1 = Z(ie,i);           % global numbering of a node that belongs
                                % to element ie and has local index i 
        for j = 1:npe           % index for local numbering
            j1 = Z(ie,j);       % global numbering of a node that belongs
                                % to element ie and has local index j 
             AG(i1,j1) = AG(i1,j1) + Pe(k)*C(i,j) + ...
                                       A(i,j) + ...
                                    Bi*B(i,j);  
        end
    end
end

% application of Dirichlet condition at left end
AG(1,:) = zeros(1,nnodes);
AG(1,1) = 1;
bG(1,1) = T0;

% solution of system
T(:,k)  = AG\bG ; 
 
 
 [c(:,k)] =Askisi_2_3_b_par(T(:,k),Pe(k));
 
end 
 
 figure(2)
plot(Pe, ((1-c(nnodes,:)).*Pe),'k')
%axis([10 200 -200 50])  
xlabel('Pe')                 % title of x axis
ylabel('(1-c)Pe')           % title of y axis