%% Exercise 32: mass transport + reaction: plugged flow tube reactor
clear; clc; close all;

% data
L  = 5; % m
D  = 1.6e-5; % m^2/s (all species)
v  = 0.005; % m/s
Nx = 100; % number of grid points
dx = L/(Nx-1);

% take min as time unit -> multiply D and v by 60
D_eff = D*60; % m^2/min
v_eff = v*60; % m/min (= 0.3 m/min)

% kinetics
k1 = 0.02; % L/(min mol)
k2 = 0.01; % L/(min mol)

% time discretization
T_end = L/v_eff;  % min, T = L/v = 5/0.3 = 16.67 min
T_end = 19;
dt = 0.001; % min 
Nt = round(T_end/dt);

x = linspace(0,L,Nx)';

% stability check
rD = D_eff*dt/dx^2;
rA = v_eff*dt/dx;
fprintf('rD = %.4f, rA = %.4f\n',rD,rA);

% initial and boundary conditions (mol/L)
CA_in = 2;
CB_in = 2;
CC_in = 0;
CD_in = 0;
CE_in = 0;

% initial: all zero inside reactor
CA = zeros(Nx,1);
CB = zeros(Nx,1);
CC = zeros(Nx,1);
CD = zeros(Nx,1);
CE = zeros(Nx,1);

% store times (min)
t_store = [4 7 11 15 19];
k_store = round(t_store/dt);

CA_store = zeros(Nx,length(t_store));
CB_store = zeros(Nx,length(t_store));
CC_store = zeros(Nx,length(t_store));
CD_store = zeros(Nx,length(t_store));
CE_store = zeros(Nx,length(t_store));

% time stepping (explicit upwind for advection, central for diffusion)
for k = 1:Nt
    CA_old = CA;
    CB_old = CB;
    CC_old = CC;
    CD_old = CD;
    CE_old = CE;

    % interior nodes i = 2:Nx-1
    for i = 2:Nx-1
        % diffusion
        d2CA = (CA_old(i+1) - 2*CA_old(i) + CA_old(i-1))/dx^2;
        d2CB = (CB_old(i+1) - 2*CB_old(i) + CB_old(i-1))/dx^2;
        d2CC = (CC_old(i+1) - 2*CC_old(i) + CC_old(i-1))/dx^2;
        d2CD = (CD_old(i+1) - 2*CD_old(i) + CD_old(i-1))/dx^2;
        d2CE = (CE_old(i+1) - 2*CE_old(i) + CE_old(i-1))/dx^2;

        % advection (upwind)
        dCA = (CA_old(i) - CA_old(i-1))/dx;
        dCB = (CB_old(i) - CB_old(i-1))/dx;
        dCC = (CC_old(i) - CC_old(i-1))/dx;
        dCD = (CD_old(i) - CD_old(i-1))/dx;
        dCE = (CE_old(i) - CE_old(i-1))/dx;

        % reaction rates
        r1 = k1*CA_old(i)*CB_old(i);
        r2 = k2*CA_old(i)*CC_old(i);

        % transport equations
        CA(i) = CA_old(i) + dt*(D_eff*d2CA - v_eff*dCA - r1 - r2);
        CB(i) = CB_old(i) + dt*(D_eff*d2CB - v_eff*dCB - r1);
        CC(i) = CC_old(i) + dt*(D_eff*d2CC - v_eff*dCC + r1 - r2);
        CD(i) = CD_old(i) + dt*(D_eff*d2CD - v_eff*dCD + r1);
        CE(i) = CE_old(i) + dt*(D_eff*d2CE - v_eff*dCE + r2);
    end

    % inlet boundary
    CA(1) = CA_in;
    CB(1) = CB_in;
    CC(1) = CC_in;
    CD(1) = CD_in;
    CE(1) = CE_in;

    % outlet boundary
    CA(end) = CA(end-1);
    CB(end) = CB(end-1);
    CC(end) = CC(end-1);
    CD(end) = CD(end-1);
    CE(end) = CE(end-1);

    % store
    if ismember(k,k_store)
        idx = find(k_store==k);
        CA_store(:,idx) = CA;
        CB_store(:,idx) = CB;
        CC_store(:,idx) = CC;
        CD_store(:,idx) = CD;
        CE_store(:,idx) = CE;
    end
end

% plot 1: CH4 (species E) over x at different times
figure;
hold on;
colors = lines(length(t_store));
for j = 1:length(t_store)
    plot(x, CE_store(:,j), 'Color', colors(j,:), 'LineWidth', 1.5);
end
xlabel('x [m]');
ylabel('concentration [mol/L]');
grid on;
title('CH_4 over x');
legend_str = cell(1,length(t_store));
for j = 1:length(t_store)
    legend_str{j} = sprintf('%d min', t_store(j));
end
legend(legend_str, 'Location', 'best');

% plot 2: all species over x after 19 min
figure;
j = length(t_store);  % last time = 19 min
plot(x, CA_store(:,j), 'b-', 'LineWidth', 1.5); hold on;
plot(x, CB_store(:,j), 'r-', 'LineWidth', 1.5);
plot(x, CC_store(:,j), 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1.5);
plot(x, CD_store(:,j), 'm-', 'LineWidth', 1.5);
plot(x, CE_store(:,j), 'g-', 'LineWidth', 1.5);
xlabel('x [m]');
ylabel('concentration [mol/L]');
grid on;
title(sprintf('species over x after %d min', t_store(j)));
legend('C_A (CH_4)', 'C_B (O_2)', 'C_C (H_2)', 'C_D (CO_2)', 'C_E (CH_4 product)', 'Location', 'best');
