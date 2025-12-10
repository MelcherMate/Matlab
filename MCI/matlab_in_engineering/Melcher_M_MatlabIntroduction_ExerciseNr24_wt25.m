disp("--------- Task 24 ---------")
disp("-- part a --")

% Default values
defaultNames = {'Carl', 'Sagan', '67';
                'Wernher', 'von Braun', '88';
                'Szergej',  'Koroljov', '71'};

prompt = {'First name:', 'Surname:', 'Age:'};

data = cell(3,4);
data(1,:) = [];

for i = 1:3
    % Input dialog for each person
    answer = inputdlg(prompt, sprintf('Enter data for person %d', i), 1, defaultNames(i,:));
    % Assign data
    data{i,1} = i;
    data{i,2} = answer{1};
    data{i,3} = answer{2};
    data{i,4} = str2double(answer{3});
end

cellData = [{'Number','First name','Surname','Age'}; data];

disp("-- part b1 --")
writecell(cellData, 'task_24b1.txt', 'Delimiter', 'tab');

disp("-- part b2 --")
writecell(cellData, 'task_24b2.xlsx', 'Sheet', 2);
T = cell2table(data, ...
    'VariableNames', {'Number','FirstName','Surname','Age'});
writetable(T, 'task_24b2.xlsx', 'Sheet', 1, 'WriteMode', 'overwrite');

disp("--------------------------");
return



