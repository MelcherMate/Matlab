% Exercise 26
% Interpolation and extrapolation using interp1

% Given measurement points
x = 0:1:15;   % original x-values
y = [0.7, 0.9, 1.4, 1.7, 1.2, 2.5, 1.9, 2.1, 3.2, 2.3, 2, 1, 4.2, 1.6, 1, 0.3];

% Define finer grids for evaluation
x_fine  = 0:0.5:17;   % medium fine grid
xx_fine = 0:0.1:17;   % very fine grid

% Part a: Linear interpolation and extrapolation

% Linear interpolation at x_fine and xx_fine
y_lin_fine = interp1(x, y, x_fine,  'linear', 'extrap');
y_lin_xx   = interp1(x, y, xx_fine, 'linear', 'extrap');

% Plot results
figure
plot(x, y, 'o', 'LineWidth', 1.5); hold on          % original data points
plot(x_fine, y_lin_fine, '+', 'LineWidth', 1.5)    % linear interp at x_fine
plot(xx_fine, y_lin_xx, ':', 'LineWidth', 1.5)     % linear interp at xx_fine

grid on
xlabel('x')
ylabel('y')
title('Linear interpolation and extrapolation')
legend('Original data', ...
       'Linear interpolation (x\_fine)', ...
       'Linear interpolation (xx\_fine)', ...
       'Location', 'best')

% Make sure all points are visible
xlim([0 17])
ylim([min(y_lin_xx)-0.5 max(y_lin_xx)+0.5])

% Part b: Spline interpolation and extrapolation

% Spline interpolation at x_fine and xx_fine
y_spline_fine = interp1(x, y, x_fine,  'spline', 'extrap');
y_spline_xx   = interp1(x, y, xx_fine, 'spline', 'extrap');

% Plot results
figure
plot(x, y, 'o', 'LineWidth', 1.5); hold on           % original data points
plot(x_fine, y_spline_fine, '+', 'LineWidth', 1.5)  % spline interp at x_fine
plot(xx_fine, y_spline_xx, ':', 'LineWidth', 1.5)   % spline interp at xx_fine

grid on
xlabel('x')
ylabel('y')
title('Spline interpolation and extrapolation')
legend('Original data', ...
       'Spline interpolation (x\_fine)', ...
       'Spline interpolation (xx\_fine)', ...
       'Location', 'best')

% Make sure all points are visible
xlim([0 17])
ylim([min(y_spline_xx)-0.5 max(y_spline_xx)+0.5])
