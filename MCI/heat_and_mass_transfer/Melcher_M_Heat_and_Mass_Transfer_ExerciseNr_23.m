% exercise23_three_layer_wall.m
% Parts a) and b) are done on paper

clear; clc; close all;

% Given values
A = 40; % m^2
T_in = 20; % °C
T_out0 = -2; % °C
T_wall_init = 6; % °C

R1 = 1.473e-3; % K/W
R2 = 5.305e-3; % K/W
R3 = 6.043e-3; % K/W
R4 = 2.212e-3; % K/W

C1 = 520e3; % J/K
C2 = 1488e3; % J/K
C3 = 480e3; % J/K

tau1 = 599.6; % s
tau2 = 4203; % s
tau3 = 777.13; % s

T1_equ = 17.84; % °C
T2_equ = 10.081; % °C
T3_equ = 1.237; % °C

% Common ODE function (3 nodes)
ode_three_layer = @(t,T,Tout) [ ...
    ((T_in - T(1))/R1 - (T(1) - T(2))/R2)/C1; ...
    ((T(1) - T(2))/R2 - (T(2) - T(3))/R3)/C2; ...
    ((T(2) - T(3))/R3 - (T(3) - Tout(t))/R4)/C3 ];

T0 = [T_wall_init; T_wall_init; T_wall_init];

% c) Average layer temperatures up to 5*tau2 (constant Tout)
t_end_c = 5*tau2;
tspan_c = [0 t_end_c];
Tout_const = @(t) T_out0;

ode_c = @(t,T) ode_three_layer(t,T,Tout_const);
[t_c,T_c] = ode23(ode_c,tspan_c,T0); 

T1_c = T_c(:,1);
T2_c = T_c(:,2);
T3_c = T_c(:,3);

figure;
plot(t_c/3600,T1_c,'b','LineWidth',1.5); hold on;
plot(t_c/3600,T2_c,'r','LineWidth',1.5);
plot(t_c/3600,T3_c,'g','LineWidth',1.5);
xlabel('time [h]');
ylabel('temperature [^oC]');
ylim([0 20]);
grid on;
title('c) average layer temperatures (constant T_{out})');
legend('plaster','brick','wood','Location','best');

% d) surface temperatures (inside / outside) up to 5*tau2
R_alpha_in  = R1/2;
R_alpha_out = R4/2;

T_inner_surf = zeros(size(t_c));
T_outer_surf = zeros(size(t_c));

for k = 1:length(t_c)
    % heat flux at inside and outside at current time
    q_in  = (T_in   - T1_c(k))/R1;   % through R1
    q_out = (T3_c(k) - T_out0)/R4;   % through R4

    % inside and outside surface temperatures
    T_inner_surf(k) = T_in   - q_in  * R_alpha_in;
    T_outer_surf(k) = T_out0 + q_out * R_alpha_out;
end

figure;
plot(t_c/3600,T_inner_surf,'b','LineWidth',1.5); hold on;
plot(t_c/3600,T_outer_surf,'r','LineWidth',1.5);
xlabel('time [h]');
ylabel('surface temperature [^oC]');
ylim([-5 20]);
grid on;
title('d) surface temperatures (constant T_{out})');
legend('inside surface','outside surface','Location','best');

% e) Periodic outside temperature
f = 1/(24*3600); % Hz
omega = 2*pi*f;
Tout_periodic = @(t) T_wall_init*sin(omega*t) + (T_wall_init - 2);

tspan_e = [0 50*3600];
ode_e = @(t,T) ode_three_layer(t,T,Tout_periodic);

[t_e,T_e] = ode23(ode_e,tspan_e,T0);
T1_e = T_e(:,1);
T2_e = T_e(:,2);
T3_e = T_e(:,3);
Tout_e = Tout_periodic(t_e);

% average layer temperatures, periodic Tout
figure;
plot(t_e/3600,T1_e,'b','LineWidth',1.5); hold on;
plot(t_e/3600,T2_e,'r','LineWidth',1.5);
plot(t_e/3600,T3_e,'y','LineWidth',1.5);
xlabel('time [h]');
ylabel('temperature [^oC]');
ylim([0 20]);
grid on;
title('e) average layer temperatures (periodic T_{out})');
legend('plaster','brick','wood','Location','best');

% surface temperatures, periodic Tout
T_inner_surf_e = zeros(size(t_e));
T_outer_surf_e = zeros(size(t_e));

for k = 1:length(t_e)
    q_in  = (T_in    - T1_e(k))/R1;
    q_out = (T3_e(k) - Tout_e(k))/R4;
    T_inner_surf_e(k) = T_in      - q_in *R_alpha_in;
    T_outer_surf_e(k) = Tout_e(k) + q_out*R_alpha_out;
end

figure;
plot(t_e/3600,T_inner_surf_e,'b','LineWidth',1.5); hold on;
plot(t_e/3600,T_outer_surf_e,'r','LineWidth',1.5);
xlabel('time [h]');
ylabel('surface temperature [^oC]');
ylim([0 20]);
grid on;
title('e) surface temperatures (periodic T_{out})');
legend('inside surface','outside surface','Location','best');
