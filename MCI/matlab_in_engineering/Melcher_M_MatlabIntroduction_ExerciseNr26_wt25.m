disp("--------- Task 26 ---------")

% Given data
x = 0:1:15;
y = [0.7, 0.9, 1.4, 1.7, 1.2, 2.5, 1.9, 2.1, 3.2, 2.3, 2, 1, 4.2, 1.6, 1, 0.3];

% Finer grids
x_fine  = 0:0.5:17;
xx_fine = 0:0.1:17;

disp("-- part a --")
y_lin_fine  = interp1(x, y, x_fine,  'linear', 'extrap');
y_lin_xx    = interp1(x, y, xx_fine, 'linear', 'extrap');

figure
plot(x, y, 'o', 'LineWidth', 1.5); hold on
plot(x_fine, y_lin_fine, '+', 'LineWidth', 1.5)
plot(xx_fine, y_lin_xx, ':', 'LineWidth', 1.5)

grid on
xlabel('x')
ylabel('y')
title('Linear interpolation and extrapolation')
legend('Original data', 'Linear interp (x\_fine)','Linear interp (xx\_fine)', 'Location', 'best')
xlim([0 17])
ylim([min(y_lin_xx)-0.5 max(y_lin_xx)+0.5])
disp("------------");

disp("-- part b --")
y_spline_fine = interp1(x, y, x_fine,  'spline', 'extrap');
y_spline_xx   = interp1(x, y, xx_fine, 'spline', 'extrap');

figure
plot(x, y, 'o', 'LineWidth', 1.5); hold on
plot(x_fine, y_spline_fine, '+', 'LineWidth', 1.5)
plot(xx_fine, y_spline_xx, ':', 'LineWidth', 1.5)

grid on
xlabel('x')
ylabel('y')
title('Spline interpolation and extrapolation')
legend('Original data', 'Spline interp (x\_fine)', ...
       'Spline interp (xx\_fine)', 'Location', 'best')

xlim([0 17])
ylim([min(y_spline_xx)-0.5 max(y_spline_xx)+0.5])

disp("--------------------------")
