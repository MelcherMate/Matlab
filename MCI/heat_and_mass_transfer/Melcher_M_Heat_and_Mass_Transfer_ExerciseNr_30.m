%% Exercise 30: 1D MASS TRANSPORT with advection and diffusion
clear; clc; clf;

% Data
L = 35; % [m]
v = 2; % [m/s]
D = 0.33; % [m^2/s]
Cin = 0.41;
C0 = 0.1;
nx = 400;

T_total = L / v;    % Travel time for passing length L

x = linspace(0, L, nx); % Spatial grid
% Time steps at 1/5, 2/5, 3/5, 4/5, and 1 * T
t = [1/5, 2/5, 3/5, 4/5, 1] * T_total; 

m = 0; % Slab geometry
sol = pdepe(m, @pde_eqn, @pde_ic, @pde_bc, x, t);

hold on; grid on;
colors = lines(length(t));
for i = 1:length(t)
    plot(x, sol(i,:,1), 'Color', colors(i,:), 'LineWidth', 1.5, ...
        'DisplayName', sprintf('%d sec', round(t(i))));
end

xlabel('x'); ylabel('concentration');
title(sprintf('PDEPE SOLVER SOLUTION: %d grid points', nx));
legend('Location', 'northeast');
axis([0 35 0.1 0.45]);

function [c, f, s] = pde_eqn(x, t, u, dudx)
    % Standard form: c*du/dt = d/dx(f) + s
    % Equation: du/dt = D*d2u/dx2 - v*du/dx
    c = 1;
    f = 0.33 * dudx;  % Diffusion term (D = 0.33)
    s = -2 * dudx;    % Advection term (v = 2)
end

function u0 = pde_ic(x)
    % Initial condition: C(t=0, x) = 0.1
    u0 = 0.1; 
end

function [pl, ql, pr, qr] = pde_bc(xl, ul, xr, ur, t)
    % Left boundary (x=0): C = 0.41 (Dirichlet)
    pl = ul - 0.41; 
    ql = 0;
    
    % Right boundary (x=L): dC/dx = 0 (Outflow/Neumann)
    pr = 0;
    qr = 1; 
end