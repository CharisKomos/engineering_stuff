function [integral] = int_D2_Gauss_1_triangle...
                      (x1,y1,x2,y2,x3,y3,N)
integral    = 0;
% Gauss-Legendre quadrature with (N)*(N) points
 
[ksi_sq,wx] = gauss(N);
[eta_sq,wy] = gauss(N);
 
KSI_sq      = zeros(N+1);
ETA_sq      = zeros(N+1);
KSI_tr      = zeros(N+1);
ETA_tr      = zeros(N+1);
 
for i = 1: N +1
    KSI_sq(:,i) = ksi_sq(i,1)*ones(N + 1,1);
end
for i = 1: N + 1
    ETA_sq(i,:) = eta_sq(i,1)*ones(1, N + 1);
end
    
% figure(1)
% for i = 1: ? + 1
    % for j = 1: ? + 1
        % plot(KSI_sq(i,j),ETA_sq(i,j),'o')
        % hold on
    % end
% end
% axis([-1,+1,-1,+1])
% hold off
% pause
 
for i = 1: N + 1
    for j = 1: N + 1
        KSI_tr(i,j) = ksi_tr(ksi_sq(i,1),eta_sq(j,1));
        ETA_tr(i,j) = eta_tr(ksi_sq(i,1),eta_sq(j,1));
    end
end
 
% figure(2)
% for i = 1: N + 1
    % for j = 1: N + 1
        % plot(KSI_tr(i,j),ETA_tr(i,j),'o')
        % hold on
    % end
% end
% axis([0,+1,0,+1])
% hold off
% pause
 
for ix = 1: N + 1
    for iy = 1: N + 1
        ksi   = KSI_tr(ix,iy);
        eta   = ETA_tr(ix,iy);
        w_x   = wx(ix,1);
        w_y   = wy(iy,1);
        x     = x1 + (x2-x1)*ksi + (x3-x1)*eta;
        y     = y1 + (y2-y1)*ksi + (y3-y1)*eta;
        hs_sq = (1 - eta_sq(iy,1))/8;     
        integral = integral + fun_x_y(x,y)*hs_sq*w_x*w_y;
    end
end
 
area     = triangle_area_D2(x1,y1,x2,y2,x3,y3);
hs_tr    = 2*area;
integral = integral * hs_tr;
 
return
