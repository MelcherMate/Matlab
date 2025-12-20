function gift()
clc
disp('')

% Height
height = 10;

% tree leaves
for row = 1:height
    numStars = 2*row - 1;
    numSpaces = height - row;
    lineText = [repmat(' ', 1, numSpaces), repmat('*', 1, numStars)];
    disp(lineText)
end

% Trunk
trunkHeight = 3;
trunkWidth  = 3;
numSpacesTrunk = height - ceil(trunkWidth/2);

% trunk line
trunkLine = [repmat(' ', 1, numSpacesTrunk), repmat('|', 1, trunkWidth)];

for t = 1:trunkHeight
    disp(trunkLine)
end

disp('')
disp('Merry Christmas!')
end
