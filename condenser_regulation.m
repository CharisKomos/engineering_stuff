% Given solution for Process Control and Regulation of Dynamic Systems
% Exercise
% Charalambos Komodromos 5098

clear;clc;
% Constant values - Problem's data
Vo         = 0.3;                                                          
A          = 0.25;                                                         
As         = 5;                                                            
xF         = 0.3;                                                          
ro_L       = 18E3;                                                         
R          = 8.314E-5;                                                     
MB         = 46;                                                           
U          = 35E3;                                                         
DHu        = 48940;                                                        
z          = 0.35;         	                                               
R1         = 9E-4;                                                         
R2         = 0.06;

% Find roots of 3d grade polynomial for steady-state value of T
T   = roots([ 0.00025809 -0.21928 62.349 -5953.1]);
% Find roots of 3d grade polynomial for steady-state value of P
p   = roots([0.00936 -0.5741 13.677 -64]);

% Steady-State values of system variables
Fs         = 1000;
Ls         = 600;
hs         = 0.54;
Vls        = 0.135;
Gs         = 400;
Es         = 400;
xls        = 0.5;
Ps         = 24;
Ts         = T(1);
Tsts       = 430.75;
ro_G       = 2586.38;
Psts       = 6.0752;
xlms       = 12;
cs         = 0.9958;
us         = 6.0752;
cb         = 0.9958;

% Initialize continuous-time transfer function.
s = tf('s');

% Initialize transfer functions of main process
GpXL = (48.6027*(1.177*s+1))/(4.05*s+1);                                   % GpXL = XL'(s)/ Pst'(s)
GpH  = (-9.9708*(1.177*s+1)*(1.29*s+1))/((s+0.7752)*(s+0.2469));           % GpH  = H'(s) / Pst'(s)
GpP  = (-0.01334*(4.05*s+1))/((s+0.7557)*(s+0.2533));                      % GpP  = P'(s) / Pst'(s)

GloadXL = (0.9259)/(4.05*s+1);
GloadP  = (-0.0046)/((s+0.7557)*(s+0.2533));
GloadH  = (0.3448*(1.29*s+1))/((s+0.7752)*(s+0.2469));

% Transfer functions of regulatory valve Gv'(s) and metric element Gm'(s)
Gv   = 4 / (0.5*s + 1);
km   = 16;
Gm   = km / (0.1*s + 1);

% Transfer function of open loop without Gc'(s)
Gol = GpXL*Gv*Gm;

% Root locus of the poles of the system
figure(1)
rlocus(Gol);

% Apply Cohen-Coon Method
[y,t] = step(Gol);
h = mean(diff(t));
dy = gradient(y, h);                                            % Numerical Derivative
[~,idx] = max(dy);                                              % Index Of Maximum
b = [t([idx-1,idx+1]) ones(2,1)] \ y([idx-1,idx+1]);            % Regression Line Around Maximum Derivative
tv = [-b(2)/b(1); (1-b(2))/b(1)];                               % Independent Variable Range For Tangent Line Plot
f = [tv ones(2,1)] * b;                                         % Calculate Tangent Line

figure(2)
plot(t, y)
hold on
plot(tv, f, '-r')                                               % Tangent Line
plot(t(idx), y(idx), '.r')                                      % Maximum Vertical
x = linspace(0,2,5000);
gradient = (y(idx)) / (t(idx)-tv(length(tv)));
tangent_eq = gradient*(x-t(idx)) + y(idx);
%plot(x, tangent_eq, '-r');

%Calculate theta and tau
theta        = tv(length(tv));
tau_plus_theta = ( y(length(y)) - y(idx) )/gradient + t(idx);
tau = tau_plus_theta - theta;

%Draw auxiliary lines
plot([t(idx) tau_plus_theta],[y(idx) y(length(y))],'-r');
plot([0 25], [y(length(y)) y(length(y))], '--g');
plot([tau_plus_theta tau_plus_theta],[0 y(length(y))],'-.g');

%Set axis limit and name axis
ylim([0 3500]); ylabel('Amplitude');
xlim([0 25]);   xlabel('Time(seconds)');
title('Step Response');
hold off

% For PI controller
Kc = (1/y(length(y)))*(tau/theta)*(0.9+ (theta/(12*tau)));
ti = (theta*(30+(3*theta)/tau))/(9+(20*theta)/tau);

% Controller's transfer function Gc'(s)
Gc      = Kc*(1 + (1/(ti*s))); %+ td*s);

% Check limitations for 20% increase of XL'(s) for Pst'(s) and 20% decrease
% for F'(s)
% About XL'(s)
Gsp1 = (km*Gc*Gv*GpXL)/(1+ Gm*Gc*Gv*GpXL);
Gsp2 = (GloadXL)/(1+ Gm*Gc*Gv*GpXL);
% About P'(s)
Gsp3 = (km*Gc*Gv*GpP)/(1+ Gm*Gc*Gv*GpXL);
Gsp4 = GloadP;
% About H'(s)
Gsp5 = (km*Gc*Gv*GpH)/(1+ Gm*Gc*Gv*GpXL);
Gsp6 = GloadH;
% Auxiliaries
Gaux1 = (km*Gc*Gv)/(1+Gc*Gv*GpXL*Gm);
Gaux2 = (GloadXL/GpXL)/(1+Gc*Gv*GpXL*Gm);

figure(3)
step(0.2*xls*Gsp1 + xls);
title('Change of XL due to set point change');
pause

figure(4)
step(0.2*xls*Gsp3 + Ps);
title('Change of P due to set point change');
pause

figure(5)
step(0.2*xls*Gsp5 + hs);
title('Change of H due to set point change');
pause

figure(6)
step(0.2*xls*Gaux1 + Psts);
title('Change of Pst due to set point change');
pause

figure(7)
step(-0.2*xls*Gsp2 +xls);
title('Change of XL due to disturbance change');
pause

figure(8)
step(-0.2*xls*Gsp4 + Ps);
title('Change of P due to disturbance change');
pause

figure(9)
step(-0.2*xls*Gsp6+hs);
title('Change of H due to disturbance change');
pause

figure(10)
step(-0.2*xls*Gaux2+Psts);
title('Change of Pst due to disturbance change');
pause
