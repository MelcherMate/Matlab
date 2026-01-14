% exercise15_he_cc_operation.m
% Parts a) b) and c) are done on paper

% Given data
m_dot_o = 3000/3600; % kg/s (oil)
cp_o = 2000; % J/kg/K
m_dot_c = 0.6; % kg/s (water)
cp_c = 4000; % J/kg/K
U = 220.75; % W/m^2/K
A_tot = 3.88; % m^2

Th_in  = 91; % oil in [°C]
Th_out = 62; % oil out [°C]
Tc_in  = 10; % water in [°C]
Tc_out = 30; % water out[°C]

C_h = m_dot_o*cp_o; % W/K
C_c = m_dot_c*cp_c; % W/K

% Effectiveness-NTU method gives exponential profiles for constant U
NTU = U*A_tot/min(C_h,C_c)            
x = linspace(0,1,200);            
A = x*A_tot;

% Temperature difference at one end:
DT1 = Th_in - Tc_out;
DT2 = Th_out - Tc_in;

% Local delta-T along the exchanger (counter-current):
theta = DT1 - (DT1-DT2).*x;

% Reconstruct local hot and cold temperatures:
Th = Th_in - (Th_in-Th_out).*x;
Tc = Th - theta;

% Plot
figure; hold on; box on;
plot(A,Th,'r','LineWidth',2);
plot(A,Tc,'b','LineWidth',2);
xlabel('Heat-transfer area A [m^2]');
ylabel('Temperature [°C]');
legend('Oil (hot)','Water (cold)','Location','best');
title('Counter-current heat exchanger temperature profiles');
