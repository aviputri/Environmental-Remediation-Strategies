% This script makes my first plot
clear
clc % to clean the command window

% make sections with %%
%% Section for variables
x = 0:0.1:10;
y = sin(x);
z = cos(x);

%% Plot
figure %to make a plot
plot(x,y)
hold on %to hold the 1st plot
plot(x,z)

%% Plot
figure
plot(x,y,x,z) %plot 2 graphs at the same time
title('plot')
legend('sin','cos')
xlabel('x')
ylabel('y')