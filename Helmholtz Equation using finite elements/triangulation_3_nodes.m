function [ne,ng,p,c,efl,gfl] = triangulation_3_nodes(ndiv)

%=================================
% discretization of a square
% subtended between -1<x<1, -1<y<1
% into 3-node triangles
%
% c: connectivity matrix
%=================================

%---------------------------------------
% parental structure with eight elements
%---------------------------------------

ne = 8;

x(1,1)= 0.0; y(1,1)= 5.0; efl(1,1)=1;  % first element
x(1,2)= 5.0; y(1,2)= 2.5; efl(1,2)=0;
x(1,3)= 5.0; y(1,3)= 5.0; efl(1,3)=1;

x(2,1)= 0.0; y(2,1)= 5.0; efl(2,1)=1;  % second element
x(2,2)= 0.0; y(2,2)= 2.5; efl(2,2)=1;
x(2,3)= 5.0; y(2,3)= 2.5; efl(2,3)=0;

x(3,1)= 0.0; y(3,1)= 2.5; efl(3,1)=1;  % third element
x(3,2)= 0.0; y(3,2)= 0.0; efl(3,2)=1;
x(3,3)= 5.0; y(3,3)= 2.5; efl(3,3)=0;

x(4,1)= 0.0; y(4,1)= 0.0; efl(4,1)=1;  % fourth element
x(4,2)= 5.0; y(4,2)= 0.0; efl(4,2)=1;
x(4,3)= 5.0; y(4,3)= 2.5; efl(4,3)=0;

x(5,1)= 5.0; y(5,1)= 2.5; efl(5,1)=0;  % fifth element
x(5,2)= 5.0; y(5,2)= 0.0; efl(5,2)=1;
x(5,3)= 10.0; y(5,3)= 0.0; efl(5,3)=1;

x(6,1)= 5.0; y(6,1)= 2.5; efl(6,1)=0;  % sixth element
x(6,2)= 10.0; y(6,2)= 0.0; efl(6,2)=1;
x(6,3)= 10.0; y(6,3)= 2.5; efl(6,3)=1;

x(7,1)= 5.0; y(7,1)= 2.5; efl(7,1)=0;  % seventh element
x(7,2)= 10.0; y(7,2)= 2.5; efl(7,2)=1;
x(7,3)= 10.0; y(7,3)= 5.0; efl(7,3)=1;

x(8,1)= 5.0; y(8,1) = 5.0; efl(8,1)=1;  % eighth element
x(8,2)= 5.0; y(8,2) = 2.5; efl(8,2)=0;
x(8,3)= 10.0; y(8,3) = 5.0; efl(8,3)=1;

%----------------
% refinement loop
%----------------

if (ndiv > 0)

    for i = 1:ndiv
        nm = 0; % count the new elements arising by each refinement loop
                % four elements will be generated in each pass
        for j = 1:ne   % loop over current elements
            % edge mid-nodes will become vertex nodes

            x(j,4) = 0.5*(x(j,1) + x(j,2)); 
            y(j,4) = 0.5*(y(j,1) + y(j,2));
        
            x(j,5) = 0.5*(x(j,2) + x(j,3)); 
            y(j,5) = 0.5*(y(j,2) + y(j,3));
        
            x(j,6) = 0.5*(x(j,3) + x(j,1)); 
            y(j,6) = 0.5*(y(j,3) + y(j,1));

            efl(j,4)= 0; 
            if (efl(j,1)==1 & efl(j,2)==1) 
                efl(j,4) = 1; 
            end
        
            efl(j,5)=0; 
            if (efl(j,2)==1 & efl(j,3)==1) 
                efl(j,5) = 1; 
            end
        
            efl(j,6)=0; 
            if (efl(j,3)==1 & efl(j,1)==1) 
                efl(j,6) = 1; 
            end

            % assign vertex nodes to sub-elements
            % these will become the "new" elements

            nm         = nm+1;     %  first sub-element
            xn(nm,1)   = x(j,1); 
            yn(nm,1)   = y(j,1); 
            efln(nm,1) = efl(j,1); 
        
            xn(nm,2)   = x(j,4); 
            yn(nm,2)   = y(j,4); 
            efln(nm,2) = efl(j,4);
        
            xn(nm,3)   = x(j,6); 
            yn(nm,3)   = y(j,6); 
            efln(nm,3) = efl(j,6);

            nm         = nm+1;     %  second sub-element
            xn(nm,1)   = x(j,4); 
            yn(nm,1)   = y(j,4); 
            efln(nm,1) = efl(j,4); 
        
            xn(nm,2)   = x(j,2); 
            yn(nm,2)   = y(j,2); 
            efln(nm,2) = efl(j,2);
        
            xn(nm,3)   = x(j,5); 
            yn(nm,3)   = y(j,5); 
            efln(nm,3) = efl(j,5);

            nm         = nm+1;      %  third sub-element
            xn(nm,1)   = x(j,6); 
            yn(nm,1)   = y(j,6); 
            efln(nm,1) = efl(j,6); 
        
            xn(nm,2)   = x(j,5); 
            yn(nm,2)   = y(j,5); 
            efln(nm,2) = efl(j,5);
        
            xn(nm,3)   = x(j,3); 
            yn(nm,3)   = y(j,3); 
            efln(nm,3) = efl(j,3);

            nm         = nm+1;      %  fourth sub-element
            xn(nm,1)   = x(j,4); 
            yn(nm,1)   = y(j,4); 
            efln(nm,1) = efl(j,4); 
        
            xn(nm,2)   = x(j,5); 
            yn(nm,2)   = y(j,5); 
            efln(nm,2) = efl(j,5);
        
            xn(nm,3)   = x(j,6); 
            yn(nm,3)   = y(j,6); 
            efln(nm,3) = efl(j,6);

        end % end of loop over current elements

        ne = 4*ne;  % number of elements has increased
                    % by a factor of four

        for k = 1:ne     % relabel the new points
                         % and put them in the master list
            for l = 1:3
                x(k,l)   = xn(k,l);
                y(k,l)   = yn(k,l);
                efl(k,l) = efln(k,l);
            end
        end
    end 

    %---------
    % plotting
    %---------

    figure(1)
    for i = 1:ne
    
        xp(1,1) = x(i,1); 
        xp(2,1) = x(i,2); 
        xp(3,1) = x(i,3); 
        xp(4,1) = x(i,1);
    
        yp(1,1) = y(i,1); 
        yp(2,1) = y(i,2); 
        yp(3,1) = y(i,3); 
        yp(4,1) = y(i,1);
    
        plot(xp, yp,'o'); hold on;
    end
    xlabel('x','fontsize',15);
    ylabel('y','fontsize',15);
    set(gca,'fontsize',15)

    %---------------------------
    % define the global nodes
    % and the connectivity table
    %---------------------------

    % three nodes of the first element are entered mannualy

    p(1,1)   = x(1,1); 
    p(1,2)   = y(1,1); 
    gfl(1,1) = efl(1,1);

    p(2,1)   = x(1,2); 
    p(2,2)   = y(1,2); 
    gfl(2,1) = efl(1,2);

    p(3,1)   = x(1,3); 
    p(3,2)   = y(1,3); 
    gfl(3,1) = efl(1,3);

    c(1,1) = 1;  % first  node of first element is global node 1
    c(1,2) = 2;  % second node of first element is global node 2
    c(1,3) = 3;  % third  node of first element is global node 3

    ng = 3;

    % loop over further elements
    % Iflag  =0 will signal a new global node

    eps = 1e-6;

    for i = 2:ne        % loop over elements
        for j = 1:3          % loop over element nodes
            Iflag = 0;
            for k = 1:ng
                if (abs(x(i,j) - p(k,1)) < eps)
                    if (abs(y(i,j) - p(k,2)) < eps)
                        Iflag = 1;    % the node has been recorded previously
                        c(i,j) = k;   % the jth local node of element i 
                                      % is the kth global node
                    end
                end
            end
            if (Iflag==0)  % record the node
                ng        = ng + 1;
                p(ng,1)   = x(i,j);
                p(ng,2)   = y(i,j);
                gfl(ng,1) = efl(i,j);
                c(i,j)    = ng;   % the jth local node of element 
                                  % is the new global node
            end
        end
    end
end

return