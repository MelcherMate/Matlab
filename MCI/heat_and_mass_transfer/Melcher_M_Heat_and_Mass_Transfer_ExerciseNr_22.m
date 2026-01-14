% exercise22_one_layer_wall.m
% Part a) is done on paper

clear; clc; close all;

% Given values
A = 40; % m^2
T1_in = 20; % inside air [°C]
T2_out0 = -2; % outside air [°C]
Twall_init = 6; % initial average wall temp [°C]

R_alpha_in = 1/(20*A); % K/W (h=20 W/m2K)
R_alpha_out = 1/(20*A); % K/W

R_wall = 5.305e-3; % K/W
R1 = R_alpha_in + R_wall/2;
R2 = R_wall/2 + R_alpha_out;

C = 1488e3; % J/K

T_eq = 9.0; % °C
tau = 4710; % s

% Common ODE for average wall temperature (one node)
ode_T = @(t,T) ((T1_in - T)./R1 + (T2_out0 - T)./R2) / C;

% b) Run of wall temperature up to about 5*tau
t_end_b = 5*tau;
tspan_b = [0 t_end_b];

[t_b, T_b] = ode23(ode_T, tspan_b, Twall_init);

figure;
plot(t_b/3600, T_b,'b','LineWidth',1.5);
xlabel('time [h]');
ylabel('wall temperature [^oC]');
grid on;
ylim([6 9]);
title('Exercise 22b: average wall temperature');
legend('avg. brick temperature','Location','best');

% c) Surface temperatures (inside/outside) up to about 5*tau
T_surf_in  = zeros(size(T_b));
T_surf_out = zeros(size(T_b));

for k = 1:length(T_b)
    q_in  = (T1_in   - T_b(k))/R1;  % through R1
    q_out = (T_b(k) - T2_out0)/R2;  % through R2
    T_surf_in(k)  = T1_in   - q_in  * R_alpha_in;
    T_surf_out(k) = T2_out0 + q_out * R_alpha_out;
end

figure;
plot(t_b/3600,T_surf_in,'b','LineWidth',1.5); hold on;
plot(t_b/3600,T_surf_out,'r','LineWidth',1.5);
xlabel('time [h]');
ylabel('surface temperature [^oC]');
grid on;
ylim([0 18]);
title('Exercise 22c: surface temperatures (constant T_{out})');
legend('inner surface','outer surface','Location','best');

% d) Periodic ambient temperature (outside air)
f      = 1/(24*3600);               
omega  = 2*pi*f;
T2_out_periodic = @(t) Twall_init*sin(omega*t) + (Twall_init - 2);

ode_T_per = @(t,T) ( (T1_in - T)./R1 + (T2_out_periodic(t) - T)./R2 ) / C;

tspan_d = [0 50*3600];
[t_d,T_d] = ode23(ode_T_per,tspan_d,Twall_init);
T2_out_d  = T2_out_periodic(t_d);

% average wall temperature
figure;
plot(t_d/3600,T_d,'b','LineWidth',1.5);
xlabel('time [h]');
ylabel('avg. brick temperature [^oC]');
grid on;
ylim([5 15]);
title('Exercise 22d: avg. brick temperature (periodic T_{out})');

% surface temperatures (use instantaneous heat fluxes)
T_surf_in_d  = zeros(size(T_d));
T_surf_out_d = zeros(size(T_d));

for k = 1:length(T_d)
    Tout_k = T2_out_d(k);
    q_in   = (T1_in   - T_d(k))/R1;
    q_out  = (T_d(k)  - Tout_k)/R2;
    T_surf_in_d(k)  = T1_in  - q_in  * R_alpha_in;
    T_surf_out_d(k) = Tout_k + q_out * R_alpha_out;
end

figure;
plot(t_d/3600,T_surf_in_d,'b','LineWidth',1.5); hold on;
plot(t_d/3600,T_surf_out_d,'r','LineWidth',1.5);
xlabel('time [h]');
ylabel('surface temperature [^oC]');
grid on;
ylim([0 20]);
title('Exercise 22d: surface temperatures (periodic T_{out})');
legend('inner surface','outer surface','Location','best');

