%% Exercise 31: 1D mass transport with advection and diffusion
clear; clc; clf;

% Data
L = 25; % [m]
v = 0.63; % [m/s]
D = 0.33; % [m^2/s]
dx = 0.05; % [m]
nx = L/dx + 1;

x = 0:dx:L;         
t = 0:4:16;
m = 0; % Slab geometry
sol = pdepe(m, @pde_eqn, @pde_ic, @pde_bc, x, t);

hold on; grid on;
colors = lines(length(t));
for i = 1:length(t)
    plot(x, sol(i,:,1), 'Color', colors(i,:), 'LineWidth', 1.5, ...
        'DisplayName', sprintf('%d s', t(i)));
end

xlabel('x (m)'); ylabel('concentration');
title('1D Mass Transport - Gaussian Distribution Progress');
legend('Location', 'northeast');
axis([0 25 0 1]);


function [c, f, s] = pde_eqn(x, t, u, dudx)
    % Equation: du/dt = D*d2u/dx2 - v*du/dx
    c = 1;
    f = 0.33 * dudx;  % Diffusion term (D = 0.33)
    s = -0.63 * dudx; % Advection term (v = 0.63)
end

function u0 = pde_ic(x)
    % Initial condition: Gaussian distribution at t=0
    % c(t=0, x) = exp(-0.5 * (x - 3)^2)
    u0 = exp(-0.5 * (x - 3)^2); 
end

function [pl, ql, pr, qr] = pde_bc(xl, ul, xr, ur, t)
    % Left boundary (x=0): Dirichlet condition C = 0
    pl = ul; 
    ql = 0;
    
    % Right boundary (x=L): Outflow condition dc/dx = 0
    pr = 0;
    qr = 1; 
end