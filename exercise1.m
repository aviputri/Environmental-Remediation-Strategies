% This program computes the concentration of TCE in the groundwater after a spill
clear
clc

%% Computation of flow velocity
n = 0.25; %porosity(-)
i = 0.0025; %gradient(-)
k = 0.1; %hydr conductivity(cm/s)
v = k*i/n; %water veolcity in x dir (cm/s)

%% Unit conversion
v = v*86400/100; %water velocity (m/d)

%% Computation of dispersion
alpha_L = 10;
D_1 = alpha_L*v;

%% Computation of retardation factor
foc = 0.005;
Koc = 126;
Kd = Koc * foc;
rho_b = 1.6;
R_d = 1+Kd*rho_b/n;

%% Computation of concentration at x=200 m and t=365 days
x = 200;
t = 365;
C0 = 1100000;
C = C0/2*erfc((R_d*x-v*t)/sqrt(4*R_d*D_1*t));
fprintf('\nConcentration after a year at 200 m: \n %2.3f ppb and the limit of permit is 5 ppb\n',C)

%% Computation of concentration for all x=1...300m, with dx=1 m, after one year, t=365
dt=14;
t_end=365*12;
t=(1:dt:t_end);
C=C0/2*erfc((R_d*x-v*t)./sqrt(4*R_d*D_1*t));

% Plot the results (x,y,color,linewidth)
figure
plot(t,C,'b',[365 365],[0 58],'r','Linewidth',1) % plot both result (blue) and the limit (red)
title('Concentration at x=200 m, for 12 years')
xlabel('t [d]')
ylabel('C [micro g/L]')

%% Computation of concentration for all x=1?300m, with dx=1 m, after one year, t=365
t=365; % Time
x=[1:1:300]; % Space vector
C=C0/2*erfc((R_d*x-v*t)/sqrt(4*R_d*D_l*t)); %notice the change from matrix operation / to element wise operation ./

% Plot the results
figure
plot(x,C,'b',[200 200],[0 58],'-r','Linewidth',1)
title('Concentration the first year for 300m')
xlabel('x [m]')
ylabel('C [ug/L]')

%% Computation of concentration for all x=1?300m, with dx=1m, for 12 years, with dt=14 days
dt=14; % Time interval [d]
t_end=365*12; % End time [d]
t=[1:dt:t_end]; % Time vector
x=[1:1:300]; % Space vector
[x,t]=meshgrid(x,t); % Spatial-temporal coordinates
% meshgrid --> to create 2 matrices so you can create combinations of 2
% vectors
% here it is a spatial and temporal grids
% t --> every 14 days
% x --> until 300 m
C=C0/2*erfc((R_d*x-v*t)./sqrt(4*R_d*D_l*t)); %notice the change from element wise operation ./ to matrix operation /

% Plot the results
figure
surf(x,t,C) %3-D shaded surface plot
shading flat % The shading function controls the color
shading of surface
colorbar % Add color bar
c=colorbar;
c.Label.String='Concentration of TCE [ug/L]';
title('Concentration for first 300m, in first 12 years')
xlabel('x [m]') % Displays x-axis related information
ylabel('t [d]') % Displays x-axis related information