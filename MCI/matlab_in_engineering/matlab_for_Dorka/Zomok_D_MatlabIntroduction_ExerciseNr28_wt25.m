disp("--------- Exercise 28 ---------")

% Read data from Excel
filename  = '/Users/matemelcher/Documents/MCI/Matlab/DATA_for_EXERCISES.xlsx';
sheetname = 'noisy_data';

data = readmatrix(filename, 'Sheet', sheetname);

x = data(:,1);
y = data(:,2);
idx = x >= 110 & x <= 200;
x = x(idx);
y = y(idx);

% a) using trapezoidal rule
disp("-- part a --")
I = trapz(x, y);

figure
subplot(3,2,1)
plot(x, y, 'b')
grid on
xlabel('x')
ylabel('y')
title('Original data + numerical integral')
text(mean(x), max(y)*0.9, ...
     sprintf('Integral = %.2f', I), ...
     'FontSize', 10, 'Color', 'r')
disp("--------------");

% b) Polynomial fit (degree 3)
disp("-- part b --")
p3 = polyfit(x, y, 3);
y_poly3 = polyval(p3, x);

subplot(3,2,2)
plot(x, y, 'o'); hold on
plot(x, y_poly3, 'r', 'LineWidth', 1.5)
grid on
xlabel('x')
ylabel('y')
title('Polynomial fit (degree 3)')
legend('Raw data', 'Polyfit deg 3')
disp("--------------");

% c) Exponential fit using polyfit
disp("-- part c --")
% y = a * exp(b*x)  --> ln(y) = ln(a) + b*x
idx_pos = y > 0;   % exponential fit needs positive values
p_exp = polyfit(x(idx_pos), log(y(idx_pos)), 1);
y_exp = exp(polyval(p_exp, x));

subplot(3,2,3)
plot(x, y, 'o'); hold on
plot(x, y_exp, 'r', 'LineWidth', 1.5)
grid on
xlabel('x')
ylabel('y')
title('Exponential fit')
legend('Raw data', 'Exponential fit')
disp("--------------");

% d) Moving average smoothing (20 points)
disp("-- part d --")
y_smooth_ma = smoothdata(y, 'movmean', 20);

subplot(3,2,4)
plot(x, y, 'o'); hold on
plot(x, y_smooth_ma, 'r', 'LineWidth', 1.5)
grid on
xlabel('x')
ylabel('y')
title('Moving average smoothing (20 points)')
legend('Raw data', 'Smoothed data')
disp("--------------");

% e) Low-pass filter smoothing
disp("-- part e --")

N = 20;                         % Filter length (number of points in moving average)
b = ones(1, N) / N;             % FIR low-pass filter coefficients (simple moving average)

% Zero-phase filtering approximation:
% 1. Pad the data at both ends by mirroring to reduce edge effects
y_padded = [flipud(y(1:N)); y; flipud(y(end-N+1:end))]; 

% 2. Apply the moving average using convolution
% 'same' ensures the output vector is the same length as the padded vector
y_lowpass = conv(y_padded, b, 'same'); 

% 3. Remove the padding to restore original vector length
y_lowpass = y_lowpass(N+1:end-N);  

% Plot the filtered result
subplot(3,2,5)
plot(x, y, 'o'); hold on             % Raw data as circles
plot(x, y_lowpass, 'r', 'LineWidth', 1.5) % Smoothed data as red line
grid on
xlabel('x')
ylabel('y')
title('Low-pass filtered data (moving average)')
legend('Raw data', 'Filtered data')
disp("--------------");

% f) Gradient of filtered data
disp("-- part f --")
dy_dx = gradient(y_lowpass, x);

subplot(3,2,6)
plot(x, dy_dx, 'k', 'LineWidth', 1.5)
grid on
xlabel('x')
ylabel('dy/dx')
title('Gradient of filtered data')

disp("--------------------------------")
