%% Solution of a system of ODE applied to ISCO
%units: mol, L, s
%this function uses ode15s to solve a system of ordinary differential %equations

% 1) create the function (ODE)
function ODE %function has always to be on top
%% zero order reaction
[T,Y]=ode15s(@zero_order,[1:8.64:8640],0.02);  %[time interval],[initial concentration]
% you have to tell to MATLAB what you mean with @zero_order --> write the
% function at the bottom
% multiple function --> only in a script which is a function
%figure
%plot(T,Y(:,1)/Y(1,1))
%% First order reaction
[T,Y]=ode15s(@first_order,[1:8.64:8640],[0.02]); 
%figure
%plot(T,Y(:,1)/Y(1,1))
%%Second order reaction
[T,Y]=ode15s(@second_order,[1:8.64:8640],[0.02,0.01,0]); 
% 3 initial concentrations (A,B,C) --> at the beginning we have no C, so
% C=0
%figure 
%plot(T,Y(:,1)/Y(1,1),T,Y(:,2)/Y(1,2),T,Y(:,3)/max(Y(:,3)))
%% Task: Check input data, make a nice plot
% this is the function with scavanger and intermediate product
[T,Y]=ode15s(@real_isco,[1:1:1000],[0.02, 0.001,0.01,0]); % 4 initial concentrations
figure 
plot(T,Y(:,1)/Y(1,1),T,Y(:,2)/Y(1,2),T,Y(:,3)/max(Y(:,3)),T,Y(:,4)/max(Y(:,4)))
legend('[Ozone]','[MBTE]','[OH radicals]','[TBA]')

% to find an index
% find(A(2)=0 (find when the concentration is 0)
% and then plot until the value of the index

% gca = characteristic of your plot (get current axis)
% ax = gca
% ax.YLim=[0,1];
% ax.XLim=[0,15];

% 2) define your inputs (t,C)
%%
function dCdt=zero_order(t,C)
k1=0.05;
dCdt(1)=-k1;
%%
function dCdt=first_order(t,C)
k1=0.001; % constant rate
dCdt(1)=-k1*C;
%%
function dCdt=second_order(t,C)
k1=0.01;
dCdt(1)=-k1*C(1)*C(2);
dCdt(2)=-k1*C(1)*C(2);
dCdt(3)=k1*C(1)*C(2);
dCdt=dCdt';
%%
function dCdt=real_isco(t,C)

%task: check input data, make a nice plot
%initial condition
k1=0.14;
k2=70;
k3=6*10^8;

%O3 - reaction
dCdt(1)=-k1*C(1)*C(2)-k2*C(1)*C(3)-k3*C(1)*C(4); %3 sink terms

%Contaminant reaction 
dCdt(2)=-k1*C(1)*C(2); %sink

%Scavenger reaction
dCdt(3)=-k2*C(1)*C(3); %sink

%Intermediate reaction product, production and consumption
dCdt(4)=k1*C(1)*C(2)-k3*C(3)*C(4); %source & sink
dCdt=dCdt';
% source term = proportional to k1*C(1)*C(2) (between oxidant and
% contaminant)