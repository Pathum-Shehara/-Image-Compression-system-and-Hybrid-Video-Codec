function macroblocks = divideIntoMacroblocks(image,macroblockSize)


global imgLength
global imgHeight

% Calculate the size of each macroblock
% macroblockSize = 8;

% Calculate the number of macroblocks in each dimension
macroblocksPerRow = floor(imgLength / macroblockSize);
macroblocksPerCol = floor(imgHeight / macroblockSize);

% Initialize cell array to store macroblocks
macroblocks = cell(macroblocksPerCol, macroblocksPerRow);

% Divide the image into macroblocks
    for i = 1:macroblocksPerCol
        for j = 1:macroblocksPerRow
            % Calculate the start and end indices of the current macroblock
            startRow = (i - 1) * macroblockSize + 1;
            endRow = i * macroblockSize;
            startCol = (j - 1) * macroblockSize + 1;
            endCol = j * macroblockSize;

            % Extract the current macroblock from the image
            macroblock = image(startRow:endRow, startCol:endCol);

            % Store the macroblock in the cell array
            macroblocks{i, j} = macroblock;
        end
    end

end