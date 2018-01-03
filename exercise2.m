%This is a Matlab script that uses the ComputeROI function to estimate the
%radius of influence of ISCO, assuming steady-state, radial flow,
%pseudo-first order degradation kinetics
clc
clear

%% Input parameters
z=3; %m vertical interval
n=0.3; %[-] given porosity
Q=12; %[L/min] --> REMEMBER TO CONVERT!!
K_H2O2=0.91; %^h^-1 degradation rate
H2O2_ini=250; %g/L initial concentration of H2O2
H2O2_t=(1e-2:1:H2O2_ini); %g/L Time dependent concentration of H2O2

% Unit conversion
Q=Q*60/10^3; %[m^3/h]
H2O2_ini=H2O2_ini*10^3; %g/m^3 %unit conversion
H2O2_t=H2O2_t*10^3; %g/m^3 %unit conversion (all vector)

%% ***** Part 1: Estimating concentration vs radius of influence *****
% Option 1: Using fminsearch
% Initialize radius of influence: matrix of size H2O2_min filled with zeros
ROI_fminsearch=zeros(size(H2O2_t)); % create the matrix

for i=1:length(H2O2_t)
ROI_fminsearch(i)=fminsearch(@(R)...            % look for R that minimizes
 norm(H2O2_t(i)./H2O2_ini-exp(-(K_H2O2*R^2*pi*z*n)/Q)),... % this expresion
 (0.1));                                         % with this starting value
end
% 0.1 is the starting value of R --> this will influence your result
% change it until you see a good result
% don't forget that "..." is only a continuation

% Graphic
figure
plot(ROI_fminsearch,H2O2_t./H2O2_ini,'r','LineWidth',2);
title('Normalized concentration vs distance')
xlabel('R [m]')
ylabel('[H_2O_2]_{min} / [H_2O_2]_{ini}')
hold on;

% Option 2: Creating a function that computes ROI
% This is a better way
% Use the function that you have uploaded: ComputeROI
ROI_fConc=ComputeROI(H2O2_ini,H2O2_t,K_H2O2,z,n,Q);
% Graphic

plot(ROI_fConc,H2O2_t./H2O2_ini,'o','MarkerSize',15); hold on;
legend('ROI using fminsearch','ROI using R = f ( [H_2O_2]_{min})')
% To compare results this plot will be added in previous plot (hold on)

%% ***** Part 2: Estimating the radius of influence versus the pumping rate *****
% Normalized concentration of 0.5
H2O2_min=0.5*H2O2_ini; %the minimum concentration doesn't go below 50%
% ROI --> when the concentration is 50% the initial concentration

% Range of pumping rates values from 0.1 L/min to 20 L/min
Qr=0.1:0.5:20; %[L/min] --> CONVERT THE UNIT!!!
Qr=Qr*60/10^3; %[m^3/h] --> converted

% compute the ROI for the range of Qr
% here the Qr is regarded as a vector
ROI_fQ=ComputeROI(H2O2_ini,H2O2_min,K_H2O2,z,n,Qr);

figure
plot(Qr,ROI_fQ)
title({'Radius of influence vs pumping rate','[H_2O_2]_{min} / [H_2O_2]_{ini} = 0.5'})
xlabel('Q [m^3/h]')
ylabel('ROI [m]')

%Remember the difference between MATLAB scripts and MATLAB functions