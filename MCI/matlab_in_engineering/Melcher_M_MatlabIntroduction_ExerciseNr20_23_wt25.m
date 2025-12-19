
disp("--------- Task 20 ---------")
xspan20 = [0 1]
y0_20   = 1

[x20,y20] = ode45(@ode20, xspan20, y0_20)

figure
plot(x20,y20,'-o')
xlabel('x')
ylabel('y')
title('Exercise 20: y'' = -x y, y(0)=1')
grid on
disp("--------------------------");

disp("--------- Task 21 ---------")
xspan21 = [1 2]
y0_21   = 2

[x21,y21] = ode45(@ode21, xspan21, y0_21)

figure
plot(x21,y21,'-o')
xlabel('x')
ylabel('y')
title('Exercise 21: y'' = x - y, y(1)=2')
grid on
disp("--------------------------");


disp("--------- Task 22 ---------")
% y1' = -3 (y1 - y2)
% y2' =  5 (y1 - y2)
% y1(0) = 30, y2(0) = 25

xspan22 = [0 5]
y0_22   = [30; 25]

[x22,y22] = ode45(@ode22, xspan22, y0_22)

y1_22 = y22(:,1)
y2_22 = y22(:,2)

figure
plot(x22,y1_22,'-o',x22,y2_22,'-x')
xlabel('x')
ylabel('y_1, y_2')
legend('y_1','y_2','Location','best')
title('Exercise 22: ODE system')
grid on
disp("--------------------------");

disp("--------- Task 23 ---------")
% y1' = 2 x sqrt(y2)
% y2' = -13 x^2 + y1
% y1(0) = 12, y2(2) = 4

xmesh23 = linspace(0,2,50)

solinit1 = bvpinit(xmesh23, @guess23_1)
solinit2 = bvpinit(xmesh23, @guess23_2)

sol1 = bvp4c(@ode23, @bc23, solinit1)
sol2 = bvp4c(@ode23, @bc23, solinit2)

x23_1 = sol1.x
y23_1 = sol1.y

x23_2 = sol2.x
y23_2 = sol2.y

figure
plot(x23_1, y23_1(1,:),'-o', x23_1, y23_1(2,:),'-x')
xlabel('x')
ylabel('y_1(x), y_2(x)')
legend('y_1 (sol1)','y_2 (sol1)','Location','best')
title('Exercise 23: BVP solution (initial guess 1)')
grid on

figure
plot(x23_2, y23_2(1,:),'-o', x23_2, y23_2(2,:),'-x')
xlabel('x')
ylabel('y_1(x), y_2(x)')
legend('y_1 (sol2)','y_2 (sol2)','Location','best')
title('Exercise 23: BVP solution (initial guess 2)')
grid on

function dydx = ode20(x,y)
dydx = -x*y
end

function dydx = ode21(x,y)
dydx = x - y
end

function dydx = ode22(x,y)
y1 = y(1)
y2 = y(2)
dydx = zeros(2,1)
dydx(1) = -3*(y1 - y2)
dydx(2) =  5*(y1 - y2)
end

function dydx = ode23(x,y)
y1 = y(1)
y2 = y(2)
dydx = zeros(2,1)
dydx(1) = 2*x*sqrt(y2)
dydx(2) = -13*x^2 + y1
end

function res = bc23(ya,yb)
res = zeros(2,1)
res(1) = ya(1) - 12
res(2) = yb(2) - 4
end

function yinit = guess23_1(x)
yinit = [12; 4]
end

function yinit = guess23_2(x)
yinit = [0; 0]
end
disp("--------------------------");

