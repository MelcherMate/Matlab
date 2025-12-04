% Task 1
disp("--------- Task 1 ---------");
x = 0;

for i = 1:10
    r = randi(10,1);
    disp(r);
    if r < 6
        x = x + 1;
    end
end

disp("There were " + string(x) + " numbers lower than 6.");
disp("--------------------------");

% Task 2
disp("--------- Task 2 ---------");
lower = 0;
equal = 0;
higher = 0;

for i = 1:20
    r1 = randi(10,1);
    r2 = randi(10,1);
    disp([r1, r2]);
    if r1 < r2
        lower = lower + 1;
    elseif r1 == r2
        equal = equal + 1;
    else
        higher = higher + 1;
    end
end

disp("There were " + string(lower) + " times where r1 was less than r2.");
disp("There were " + string(equal) + " times where r1 was greater than r2.");
disp("There were " + string(higher) + " times where r1 was equal to r2.");
disp("--------------------------");

% Task 3
disp("--------- Task 3 ---------");
k = 1;

while k < 7
    disp("Loop number " + string(k));
    k = k + 1;
end

disp("The loop is finished. K reached " + string(k) + ".");
disp("--------------------------");

% Task 4
disp("--------- Task 4 ---------");
count = 0;
r1 = randi(10,1);
r2 = randi(10,1);

while (r1 ~= r2) && (count < 100)
    r1 = randi(10,1);
    r2 = randi(10,1);
    count = count + 1;
    fprintf("r1: %d, r2: %d\n", r1, r2);
    count;
end

fprintf("Loop stopped after %d iterations.\n", count)
disp("--------------------------");

% Task 5.a
disp("--------- Task 5.a ---------");
c = 2;

formulaA = 5 * c *  (exp(-1 * ( 3 / sqrt(2)))/ (log(c)*23)) + c^4;

disp("The result of the formula is: " + string(formulaA));
disp("--------------------------");

% Task 5.b
disp("--------- Task 5.b ---------");
A = 2;
D = -1;
B = 10;
phi = 90; % degrees

formulaB = abs( (A * D) / 2 * log( exp( asin( sind(phi) ) / log(B))));

disp("The result of the formula is: " + string(formulaB));
disp("--------------------------");

% Task 6
disp("--------- Task 6 ---------");
A= [2, 7, 9, 3, 6];
B = [13, 12, 15];

% Amax
Amax = max(A);
disp("The maximum value in A is: " + string(Amax));

%Amin
Amin = min(A);
disp("The minimum value in A is: " + string(Amin));

%Amean
Amean = mean(A);
disp("The mean value of A is: " + string(Amean));

%Asum
Asum = sum(A);
disp("The sum of all values in A is: " + string(Asum));

%A3
A3 = A(1:3)

%A235
A235 = A([2,3,5])

%AB
AB = [A B]

%BB
BB = [B*10 B*14]

%ABB
BB = [B 10 14]
ABB = A + BB

 disp("It is NOT possible to multiply A * BB at first because: A has size 1x5 and BB has size 1x5")