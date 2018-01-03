%ComputeROI is a MATLAB function (not a MATLAB script!)
%
%Description of the function:
%This function determines the minimun distance from the injection point
%of the well reduce pollutant concentration and works as
%
% ROI=ComputeROI(H2O2_ini,H2O2_min,K_H2O2,z,n,Q)
%
%Inputs:
%initial peroxide concentration,time dependent peroxide
%concentration,reaction rate, vertical interval, porosity and pumping rate
%
%Output: radius of influence
function ROI=ComputeROI(H2O2_ini,H2O2_min,K_H2O2,z,n,Q)
ROI=sqrt(-log(H2O2_min./H2O2_ini)*Q/(K_H2O2*pi*z*n));
% REMEMBER:
% *Define the function name, and the input and output variables
% *Save the MATLAB file with the same name of the function