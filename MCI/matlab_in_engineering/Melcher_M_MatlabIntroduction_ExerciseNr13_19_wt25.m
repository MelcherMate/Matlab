% Task 13
disp("--------- Task 13 ---------")
mulligan = {'max', 23; [2, 4, 5, 1], 'house'}

mulligan{2,1}(3) = 6

secondletter = mulligan{2,2}(2)
disp("--------------------------");

% Task 14
disp("--------- Task 14 ---------")
e=2;
f=1;
g=3;
h=4;

disp("-- part a --")
[a, b, c] = func(e,f,g,h)

function [a,b,c] = func(e,f,g,h)
    a = e + f + g + h;
    b = e * f;
    c = e + f*g;
end
disp("-- part b --")
e = 2;
f = 1;
g = 3;

[a1, b1, c1] = myfun(e)
[a2, b2, c2] = myfun(e,f)
[a3, b3, c3] = myfun(e,f,g)

function [a,b,c] = myfun(varargin);
    n = nargin;
    if n == 1
        e = varargin{1};
        a = e;
        b = 0;
        c = 0;
    elseif n == 2
        e = varargin{1};
        f = varargin{2};
        a = e + f;
        b = e * f;
        c = e + f;
    elseif n == 3
        e = varargin{1};
        f = varargin{2};
        g = varargin{3};
        a = e + f + g;
        b = e * f;
        c = e + f*g;
    else
        error("Function requires 1, 2, or 3 input arguments.");
    end
end
disp("--------------------------");

% Task 15
disp("--------- Task 15 ---------")

x = 1:1:10
y1 = 2*x
y2 = x.^(1/2)

figure
plot(x, y1, '-o', 'LineWidth', 2)
hold on
plot(x, y2, '-s', 'LineWidth', 2)
hold off

xlabel("x values")
ylabel("Function values")
title("Functions y_1 = 2x and y_2 = sqrt(x)")
legend("y_1 = 2x", "y_2 = sqrt(x)", "Location", "northwest")
grid on
disp("--------------------------");

% Task 16
disp("--------- Task 16 ---------")

t = 0 : pi/50 : 10*pi;
x = exp(-0.05.*t) .* sin(t);
y = exp(-0.05.*t) .* cos(t);
z = t;

figure
plot3(x, y, z, 'LineWidth', 2)
grid on
xlabel("x = e^{-0.05t} sin(t)")
ylabel("y = e^{-0.05t} cos(t)")
zlabel("z = t")
title("3D Spiral Curve Using plot3")
legend("Spiral trajectory", "Location", "best")
view(45, 25)
disp("--------------------------");

% Task 17
disp("--------- Task 17 ---------")
x = -2:0.1:2;
y = -2:0.1:2;
[X, Y] = meshgrid(x, y);

Z = X .* exp(-((X - Y.^2).^2 - Y.^2));

figure

disp("-- part a --")
subplot(1,3,1)
mesh(X, Y, Z)
xlabel("X-axis")
ylabel("Y-axis")
zlabel("Z-axis")
title("Mesh Plot of z = x e^{-((x-y^2)^2 - y^2)}")
grid on

disp("-- part b --")
subplot(1,3,2)
surf(X, Y, Z)
shading interp
xlabel("X-axis")
ylabel("Y-axis")
zlabel("Z-axis")
title("Surface Plot (surf)")
colorbar
grid on

disp("-- part c --")
subplot(1,3,3)
contour(X, Y, Z, 20)
xlabel("X-axis")
ylabel("Y-axis")
title("Contour Plot of the Surface")
grid on
disp("--------------------------");

% Task 18
disp("--------- Task 18 ---------")
f = @(x) x.^4 + 2*x.^2 + x - 24

disp("-- Using fzero --")
root_fzero = fzero(f, 1)
disp("--------------------------");

disp("-- Using fixed-point iteration --")
x_start = 2;
x = x_start;
maxdiff = 0.001;
max_counts = 100 ;
diff = maxdiff + 1;
counts = 0;

while (diff > maxdiff) && (counts < max_counts)
    x_new = (24 - 2*x.^2 - x).^(1/4);
    diff = abs(x_new - x);
    x = x_new;
    counts = counts + 1;
end

root_fixedpoint = x
iterations = counts
disp("--------------------------");

% Task 19
disp("--------- Task 19 ---------")

% GIVEN DATA
d = 0.02;                  % pipe diameter [m]
k = 0.00002;               % roughness [m]
rho = 998;                 % density [kg/m³]
nu = 1.002e-6;             % kinematic viscosity [m²/s]
mdot = 0.3;                % mass flow [kg/s]
L = 100;                   % pipe length [m]

Vdot = mdot / rho         % m³/s
A = pi * (d^2) / 4        % cross-section [m²]
v = Vdot / A              % flow velocity [m/s]

Re = v * d / nu

if Re < 2300
    disp("Laminar flow → Using λ = 64 / Re")
    lambda_laminar = 64 / Re
end

disp("----- Fixed-Point Iteration for λ -----")

% Colebrock rearranged into λ = f(λ)
g = @(lambda) 1 ./ ( ...
    ( -2*log10( 2.51./(Re*sqrt(lambda)) + k/(3.71*d) ) ).^2 );

lambda = 0.02;    
tol = 1e-6;
maxIter = 1000;

for i = 1:maxIter
    lambda_new = g(lambda);
    if abs(lambda_new - lambda) < tol
        break
    end
    lambda = lambda_new;
end

lambda_fixedpoint = lambda
disp("Number of iterations:")
i

disp("----- Solving λ using fzero -----")

f = @(lambda) 1/sqrt(lambda) + 2*log10( 2.51/(Re*sqrt(lambda)) + k/(3.71*d) );

lambda_fzero = fzero(f, 0.02)

disp("----- Pressure Loss Calculation -----")

zeta = lambda_fixedpoint * (L / d)
DeltaP = zeta * 0.5 * rho * v^2

disp("Pressure loss Δp [Pa]:")
DeltaP
disp("--------------------------");