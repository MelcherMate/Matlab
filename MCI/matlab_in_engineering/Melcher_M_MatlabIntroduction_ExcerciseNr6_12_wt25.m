% Task 8

disp("--------- Task 8 ---------")
first_name= 'Kurt';
surename= 'Miller';
age = 23;

full_name= [first_name, ' ', surename]

name(1) = 'G';

message = strcat(first_name, ' is', 32, num2str(age), ' years old.');

disp("--------------------------")

% Task 9
disp("--------- Task 9 ---------")
A=[4,2,1;6,2,9];
B=[3,2,1;6,7,9];
count_equal = 0;

s = size(A);
disp(s);

nr_of_rows = s(1);
nr_of_columns = s(2);

for row_index = 1:1:nr_of_rows
    for col_index = 1:1:nr_of_columns
        if A(row_index, col_index) == B(row_index, col_index)
            count_equal = count_equal + 1;
        end
    end
end

disp(['Number of equal elements: ', num2str(count_equal)]);
disp("--------------------------");

% Task 10
disp("--------- Task 10 ---------")
A = [1,3,2;2,6,9];
B = [3,7,4;8,5,6];
C = [3,7;8,5];

AtimesB = A .* B;
disp(string(AtimesB));

A_column2 = A(:,2);
C_row1 = C(1,:);

A2B1 = C_row1 + A_column2';
disp(string(A2B1));

B1 = B;     
B1(2,:) = 1;
disp(string(B1));

Atrans = A';
disp(string(Atrans));

Cinv = inv(C);
disp(string(Cinv));

B_sorted = B;
B_sorted(2,:) = sort(B(2,:), 'descend');
disp(string(B_sorted));

A_first2 = A(:,1:2);
B_last = B(:,3);
A2B3 = [A_first2, B_last];
disp(string(A2B3));
disp("--------------------------");

% Task 11
disp("--------- Task 11 ---------")
disp("--part a--")
A = [-2 3; 4 1];
B = [5; -2];
X = inv(A) * B;
disp("The solution X is:")
disp(string(X));

disp("--part b--")
A = [1 1 1; 0 1 1; 0 0 1];
B = [2 ; -1 ; 3];
X = inv(A) * B;
disp("The solution X is:")
disp(string(X));
disp("--------------------------");