function gift()
    clc;
    
    % Define the Escape character
    esc = char(27);
    green = [esc '[32m'];
    red   = [esc '[31m'];
    reset = [esc '[0m'];

    height = 10;

    % Tree leaves
    for row = 1:height
        numStars = 2*row - 1;
        numSpaces = height - row;
        
        spaces = repmat(' ', 1, numSpaces);
        stars  = repmat('*', 1, numStars);
        
        % Combining the color codes directly into the string
        fprintf('%s%s%s%s\n', spaces, green, stars, reset);
    end

    % Trunk
    trunkHeight = 3;
    trunkWidth  = 3;
    numSpacesTrunk = height - floor(trunkWidth/2) - 1;
    
    trunkLine = repmat('|', 1, trunkWidth);
    spacesTrunk = repmat(' ', 1, numSpacesTrunk);

    for t = 1:trunkHeight
        fprintf('%s%s%s%s\n', spacesTrunk, red, trunkLine, reset);
    end

    fprintf('\n%sMerry Christmas!%s\n', green, reset);
end