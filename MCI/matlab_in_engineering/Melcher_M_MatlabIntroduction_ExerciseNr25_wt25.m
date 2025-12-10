disp("--------- Task 25 ---------")
disp("-- part a --")

T = readtable('task_24b1.txt', 'Delimiter', '\t');
choice = questdlg('Choose sorting direction for AGE:', ...
                  'Sort direction', ...
                  'ascend', 'descend', 'ascend');

T_sorted = sortrows(T, 'Age', choice);
writetable(T_sorted, 'task_25a.txt', 'Delimiter', '\t');

disp("-- part b --")

T2 = readtable('task_24b2.xlsx', 'Sheet', 1);  
choice2 = questdlg('Choose sorting direction for AGE:', ...
                   'Sort direction', ...
                   'ascend', 'descend', 'ascend');
T2_sorted = sortrows(T2, 'Age', choice2);
writetable(T2_sorted, 'task_24b2.xlsx', 'Sheet', 3, 'WriteMode', 'overwrite');

disp("Part b completed!")
disp("--------------------------")
