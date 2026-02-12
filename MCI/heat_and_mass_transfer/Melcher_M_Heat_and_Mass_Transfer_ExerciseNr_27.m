% Data
R = 0.05;               % m
rho = 1000;             % kg/m^3
c = 4000;               % J/kg K
lambda = 0.55;          % W/m K
alpha_conv = 100;       % W/m^2 K
T_initial = 10;         % C
T_fluid = 0;            % C
nodes = 51;             % Number of nodes
total_time = 60 * 60;   % 60 mins

% Derived Quantities
dr = R / (nodes - 1);
r = linspace(0, R, nodes);
alpha_diff = lambda / (rho * c);

dt = 0.5 * (dr^2 / (2 * alpha_diff)); 
nt = ceil(total_time / dt);
dt = total_time / nt; 

T = ones(nodes, 1) * T_initial;
T_new = T;

plot_times = (10:10:60) * 60; 
figure; hold on; grid on;
plot(r, ones(size(r))*T_initial, 'LineWidth', 2, 'DisplayName', '0 min');

% Time integration
for i = 1:nt
    time_sec = i * dt;
    for j = 2:nodes-1
        d2Tdr2 = (T(j+1) - 2*T(j) + T(j-1)) / dr^2;
        dTdr = (T(j+1) - T(j-1)) / (2*dr);
        T_new(j) = T(j) + dt * alpha_diff * (d2Tdr2 + (2/r(j)) * dTdr);
    end

    T_new(1) = T(1) + dt * 3 * alpha_diff * (2 * (T(2) - T(1)) / dr^2);
    T_new(nodes) = (lambda/dr * T_new(nodes-1) + alpha_conv * T_fluid) / (lambda/dr + alpha_conv);
    T = T_new;

    if any(abs(time_sec - plot_times) < dt/2)
        plot(r, T, 'LineWidth', 1.5, 'DisplayName', sprintf('%d min', time_sec/60));
    end
end

% Formatting the Plot
xlabel('Radius r (m)');
ylabel('Temperature (^\circC)');
title('Transient 1D Heat Conduction in a Sphere');
legend('Location', 'northeast');
ylim([0 10.5]);