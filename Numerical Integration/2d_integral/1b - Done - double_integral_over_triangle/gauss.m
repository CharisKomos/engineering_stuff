function [t,w] = gauss(N)
z = [1:N];
beta = 1/2./sqrt(1-(2*z).^(-2));        
T = diag(beta,1) + diag(beta,-1);       
[V,D] = eig(T);                         
t = diag(D); 
[t,i] = sort(t);                        % nodes
w = [2*V(1,i).^2].';                    % weights
return
