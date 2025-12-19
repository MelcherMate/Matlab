disp("--------- Exercise 27 ---------")

filename = '/Users/matemelcher/Documents/MCI/Matlab/DATA_for_EXERCISES.xlsx';
sheetname = 'heatpumpdata';

raw = readmatrix(filename, 'Sheet', sheetname);
raw = raw(~all(isnan(raw),2), :);
raw = raw(:, ~all(isnan(raw),1));

Tc  = raw(1, 2:end);      % condensation temperature
Te  = raw(2:end, 1);      % evaporation temperature
COP = raw(2:end, 2:end);  % COP matrix

Tc  = Tc(:)';    
Te  = Te(:);      

% Original surface plot
figure
surf(Tc, Te, COP)
xlabel('Condensation temperature')
ylabel('Evaporation temperature')
zlabel('COP')
title('Original COP data')
shading interp
colorbar

% Create finer grids (15 values)
Tc_fine = linspace(min(Tc), max(Tc), 15);
Te_fine = linspace(min(Te), max(Te), 15);

disp("2D interpolation (correct interp2 usage)");
COP_fine = interp2(Tc, Te, COP, Tc_fine, Te_fine');

% Interpolated surface plot
figure
surf(Tc_fine, Te_fine, COP_fine)
xlabel('Condensation temperature')
ylabel('Evaporation temperature')
zlabel('COP')
title('Interpolated COP data')
shading interp
colorbar

% Excel output
output = NaN(length(Te_fine)+1, length(Tc_fine)+1);
output(1, 2:end)   = Tc_fine;
output(2:end, 1)   = Te_fine';
output(2:end, 2:end) = COP_fine;

writematrix(output, filename, 'Sheet', 3)

disp("Interpolated COP values written to Sheet 3")
disp("-------------------------------------------")
