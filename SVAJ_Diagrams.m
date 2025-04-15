close all; clear all; clc

%given values from table 8-2
C_v = 1.7596
C_a = 5.5280
C_j = 69.466
b = 0.25
c = 0
d = .75
total_time = 10
Beta = [40 100 90 20 30 80]
h = [2.5 0 -1.5 0 -1 0]

%define resolution
n = 100
image_res = 300;

%calculated values
length = length(Beta)
w = 2*pi/total_time
delta_t = total_time*Beta/360
cum_sum_h = [0, cumsum(h(1:end-1))]; 
cum_sum_deg = [0, cumsum(Beta(1:end-1))] 

%define equations using eqns 8-15 through 8-19
syms x
zone_1 = [C_a*(b/pi*x-(b/pi)^2*sin(pi/b*x));C_a*(b/pi-b/pi*cos(pi/b*x));C_a*sin(pi/b*x);C_a*pi/b*cos(pi/b*x)];
zone_2 = [C_a*(x^2/2+b*(1/pi-1/2)*x+b^2*(1/8-1/pi^2));C_a*(x+b*(1/pi-1/2));C_a;0];
zone_3 = [C_a*((b/pi+c/2)*x+(d/pi)^2+b^2*(1/8-1/pi^2)-(1-d)^2/8-(d/pi)^2*cos(pi/d*(x-(1-d)/2)));C_a*(b/pi+c/2+d/pi*sin(pi/d*(x-(1-d)/2)));C_a*cos(pi/d*(x-(1-d)/2));-C_a*pi/d*sin(pi/d*(x-(1-d)/2))];
zone_4 = [C_a*(-x^2/2+(b/pi+1-b/2)*x+(2*d^2-b^2)*(1/pi^2-1/8)-1/4);C_a*(-x+b/pi+1-b/2);-C_a;0];
zone_5 = [C_a*(b/pi*x+(2*(d^2-b^2))/pi^2+((1-b)^2-d^2)/4-(b/pi)^2*sin(pi/b*(x-1)));C_a*(b/pi-b/pi*cos(pi/b*(x-1)));C_a*sin(pi/b*(x-1));C_a*pi/b*cos(pi/b*(x-1))];
i = 1;
s_func = piecewise(x<=b/2,zone_1(i),b/2<x<=b/2+c/2,zone_2(i),(1-d)/2<x<=(d+1)/2,zone_3(i),(1+d)/2<x<=1-b/2,zone_4(i),1-b/2<x<=1,zone_5(i)); i = 2;
v_func = piecewise(x<=b/2,zone_1(i),b/2<x<=b/2+c/2,zone_2(i),(1-d)/2<x<=(d+1)/2,zone_3(i),(1+d)/2<x<=1-b/2,zone_4(i),1-b/2<x<=1,zone_5(i)); i = 3;
a_func = piecewise(x<=b/2,zone_1(i),b/2<x<=b/2+c/2,zone_2(i),(1-d)/2<x<=(d+1)/2,zone_3(i),(1+d)/2<x<=1-b/2,zone_4(i),1-b/2<x<=1,zone_5(i)); i = 4;
j_func = piecewise(x<=b/2,zone_1(i),b/2<x<=b/2+c/2,zone_2(i),(1-d)/2<x<=(d+1)/2,zone_3(i),(1+d)/2<x<=1-b/2,zone_4(i),1-b/2<x<=1,zone_5(i));

%plot displacement
f1 = figure(1);
hold on
title('Displacement'); set(gca, 'FontName', 'Times New Roman'); % Set font for axes ticks
xlabel('Cam Rotation Angle (degrees)'); ylabel('Displacement (in)')
xlim([0 360]); ylim([0 3])
for k = 1:length
    x_vals = linspace(0,1,n);
    s_vals = cum_sum_h(k)+h(k)*subs(s_func,x,x_vals);
    deg_vals = cum_sum_deg(k)+Beta(k)*x_vals;
    plot(deg_vals,s_vals,'magenta')
end
exportgraphics(f1,'s_plot.png','Resolution',image_res);

%plot velocity
f2 = figure(2);
hold on
title('Velocity'); set(gca, 'FontName', 'Times New Roman'); % Set font for axes ticks
xlabel('Cam Rotation Angle (degrees)'); ylabel('Velocity (in/rad)')
xlim([0 360]); ylim([-7 7])
for k = 1:length
    x_vals = linspace(0,1,n);
    v_vals = h(k)/delta_t(k)/w*subs(v_func,x,x_vals);
    deg_vals = cum_sum_deg(k)+Beta(k)*x_vals;
    plot(deg_vals,v_vals,'red')
end
exportgraphics(f2,'v_plot.png','Resolution',image_res);

%plot acceleration
f3 = figure(3);
hold on
title('Acceleration'); set(gca, 'FontName', 'Times New Roman'); % Set font for axes ticks
xlabel('Cam Rotation Angle (degrees)'); ylabel('Acceleration (in/rad^2)')
xlim([0 360]); ylim([-30 30])
for k = 1:length
    x_vals = linspace(0,1,n);
    a_vals = h(k)/delta_t(k)^2/w^2*subs(a_func,x,x_vals);
    deg_vals = cum_sum_deg(k)+Beta(k)*x_vals;
    plot(deg_vals,a_vals,'blue')
end
exportgraphics(f3,'a_plot.png','Resolution',image_res);

%plot jerk
f4 = figure(4);
hold on
title('Jerk'); set(gca, 'FontName', 'Times New Roman'); % Set font for axes ticks
xlabel('Cam Rotation Angle (degrees)'); ylabel('Jerk (in/rad^3)')
xlim([0 360]); ylim([-600 600])
Degree_vals = [0]; J_vals = [0];
for k = 1:length
    x_vals = linspace(0,1,n);
    j_vals = h(k)/delta_t(k)^3/w^3*subs(j_func,x,x_vals);
    J_vals = [J_vals j_vals];
    deg_vals = cum_sum_deg(k)+Beta(k)*x_vals;
    Degree_vals = [Degree_vals deg_vals];
end
plot(Degree_vals,J_vals,'green')
exportgraphics(f4,'j_plot.png','Resolution',image_res);



