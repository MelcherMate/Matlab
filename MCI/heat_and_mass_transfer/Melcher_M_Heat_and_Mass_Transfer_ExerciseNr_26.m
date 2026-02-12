%exercise26_transient_1D_heat_conduction.m

clear; clc; close all;

%data
L  = 1; % m
a  = 22.6e-6; % m^2/s
Nx = 40; % number of interior points
dx = L/(Nx-1);
dt = 1; % s
Nt = 4*3600; % 4 h

x = linspace(0,L,Nx)';

r = a*dt/dx^2;

%time moments to store (s)
t_store = [1 2 3 4]*3600;
k_store = t_store/dt;

%a) Dirichlet: T_left=50, T_right=0, uniform initial T=0

T = zeros(Nx,1);
T(1)   = 50;
T(end) = 0;

T_a = zeros(Nx,length(t_store));

for k = 1:Nt
    T_old = T;
    for i = 2:Nx-1
        T(i) = T_old(i) + r*(T_old(i+1) - 2*T_old(i) + T_old(i-1));
    end
    T(1)   = 50;
    T(end) = 0;
    if ismember(k,k_store)
        idx = find(k_store==k);
        T_a(:,idx) = T;
    end
end

figure;
plot(x,T_a(:,1),'LineWidth',1.5); hold on;
plot(x,T_a(:,2),'LineWidth',1.5);
plot(x,T_a(:,3),'LineWidth',1.5);
plot(x,T_a(:,4),'LineWidth',1.5);
xlabel('x [m]');
ylabel('temperature [^oC]');
grid on;
title('a) Dirichlet T_{left}=50, T_{right}=0');
legend('1 h','2 h','3 h','4 h','Location','best');

%b) Dirichlet left, Neumann right (adiabatic), T_init=0

T = zeros(Nx,1);
T(1) = 50;

T_b = zeros(Nx,length(t_store));

for k = 1:Nt
    T_old = T;
    for i = 2:Nx-1
        T(i) = T_old(i) + r*(T_old(i+1) - 2*T_old(i) + T_old(i-1));
    end
    T(1)   = 50;
    T(end) = T(end-1); % dT/dx = 0
    if ismember(k,k_store)
        idx = find(k_store==k);
        T_b(:,idx) = T;
    end
end

figure;
plot(x,T_b(:,1),'LineWidth',1.5); hold on;
plot(x,T_b(:,2),'LineWidth',1.5);
plot(x,T_b(:,3),'LineWidth',1.5);
plot(x,T_b(:,4),'LineWidth',1.5);
xlabel('x [m]');
ylabel('temperature [^oC]');
grid on;
title('b) Dirichlet left 50, right insulated');
legend('1 h','2 h','3 h','4 h','Location','best');

%c) Initial T(x,0)=50*sin(pi*x), Dirichlet 0 at both ends

T = 50*sin(pi*x);
T(1)   = 0;
T(end) = 0;

T_c = zeros(Nx,length(t_store));
T_c0 = T; % for t=0 surface
t3D  = 0:dt:Nt; % for surface plot
Tsurf = zeros(Nx,length(t3D));
Tsurf(:,1) = T;

idx3D = 1;

for k = 1:Nt
    T_old = T;
    for i = 2:Nx-1
        T(i) = T_old(i) + r*(T_old(i+1) - 2*T_old(i) + T_old(i-1));
    end
    T(1)   = 0;
    T(end) = 0;
    if ismember(k,k_store)
        idx = find(k_store==k);
        T_c(:,idx) = T;
    end
    idx3D = idx3D + 1;
    Tsurf(:,idx3D) = T;
end

figure;
plot(x,T_c0,'LineWidth',1.5); hold on;
plot(x,T_c(:,1),'LineWidth',1.5);
plot(x,T_c(:,2),'LineWidth',1.5);
plot(x,T_c(:,3),'LineWidth',1.5);
plot(x,T_c(:,4),'LineWidth',1.5);
xlabel('x [m]');
ylabel('temperature [^oC]');
grid on;
title('c) T(x,0)=50 sin(\pi x), T_{left}=T_{right}=0');
legend('0 h','1 h','2 h','3 h','4 h','Location','best');

% 3D surface: x vs time vs T
[Xg,Tg] = meshgrid(x,t3D);
figure;
surf(Xg, Tg, Tsurf');
xlabel('x [m]');
ylabel('time [s]');
zlabel('temperature [^oC]');
shading interp;
title('c) temperature evolution (surface)');
