function [area] = triangle_area_D2(x1,y1,x2,y2,x3,y3)
d1 = sqrt((x1-x2)^2+(y1-y2)^2);      % length of side 1-2
d2 = sqrt((x2-x3)^2+(y2-y3)^2);      % length of side 2-3
d3 = sqrt((x3-x1)^2+(y3-y1)^2);      % length of side 3-1
p  = (d1+d2+d3)/2;                   % halh perimeter
area = sqrt(p*(p-d1)*(p-d2)*(p-d3)); % Heron's equation
return

