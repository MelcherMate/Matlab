disp("--------- Exercise 27 ---------")

% Full path to the Excel file that contains the heat pump data.
filename = '/Users/matemelcher/Documents/MCI/Matlab/DATA_for_EXERCISES.xlsx';

% Name of the worksheet in the Excel file that holds the COP table.
sheetname = 'heatpumpdata';

% Read the raw numeric data from the given sheet.
% readmatrix returns a numeric matrix (non‑numeric cells become NaN).
raw = readmatrix(filename, 'Sheet', sheetname);

% Remove rows that are entirely NaN.
% This cleans out empty or header rows that contain no numeric values.
raw = raw(~all(isnan(raw),2), :);

% Remove columns that are entirely NaN.
% This removes empty columns on the right side of the table.
raw = raw(:, ~all(isnan(raw),1));

% After cleaning, the first row (from column 2 onward) contains
% the condensation temperatures (column headers of the COP table).
Tc  = raw(1, 2:end);      % vector of condensation temperatures

% The first column (from row 2 downward) contains
% the evaporation temperatures (row headers of the COP table).
Te  = raw(2:end, 1);      % vector of evaporation temperatures

% The interior of the matrix (rows 2:end, columns 2:end)
% contains the COP values for each (Te, Tc) combination.
COP = raw(2:end, 2:end);  % COP matrix (size: length(Te) × length(Tc))

% Make sure Tc is a row vector and Te is a column vector.
% This orientation is expected by surf and interp2.
Tc  = Tc(:)';    % force Tc to be 1 × n
Te  = Te(:);     % force Te to be m × 1

% ----- Original surface plot -----

figure
% surf expects X (Tc), Y (Te), and Z (COP) with matching dimensions.
surf(Tc, Te, COP)
xlabel('Condensation temperature')
ylabel('Evaporation temperature')
zlabel('COP')
title('Original COP data')
shading interp      % smooth color shading between grid points
colorbar            % show color scale for COP values

% ----- Create finer grids for interpolation -----

% Create 15 equally spaced condensation temperatures
% between the original minimum and maximum Tc.
Tc_fine = linspace(min(Tc), max(Tc), 15);

% Create 15 equally spaced evaporation temperatures
% between the original minimum and maximum Te.
Te_fine = linspace(min(Te), max(Te), 15);

disp("2D interpolation (correct interp2 usage)")

% Perform 2D interpolation of COP values onto the finer grid.
% Tc and Te define the original grid, COP the original values.
% Tc_fine (row) and Te_fine' (column) define the new grid.
COP_fine = interp2(Tc, Te, COP, Tc_fine, Te_fine');

% ----- Plot interpolated surface -----

figure
surf(Tc_fine, Te_fine, COP_fine)
xlabel('Condensation temperature')
ylabel('Evaporation temperature')
zlabel('COP')
title('Interpolated COP data')
shading interp
colorbar

% ----- Prepare output matrix for writing back to Excel -----
% The Excel sheet will have:
%   first row:    empty, then Tc_fine values as column headers
%   first column: empty, then Te_fine values as row headers
%   interior:     COP_fine values.

% Preallocate output matrix with NaNs.
% Size is (number of Te_fine + 1 header row) by (number of Tc_fine + 1 header column).
output = NaN(length(Te_fine)+1, length(Tc_fine)+1);

% Fill first row (from column 2 onward) with the fine condensation temperatures.
output(1, 2:end)   = Tc_fine;

% Fill first column (from row 2 downward) with the fine evaporation temperatures.
output(2:end, 1)   = Te_fine';

% Fill the interior block with the interpolated COP values.
output(2:end, 2:end) = COP_fine;

% Write the matrix into the same Excel file, into sheet number 3.
% (This will overwrite the existing contents of sheet 3.)
writematrix(output, filename, 'Sheet', 3)

disp("Interpolated COP values written to Sheet 3")
disp("-------------------------------------------")
