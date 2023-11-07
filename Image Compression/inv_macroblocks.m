function Deco_Image = inv_divideIntoMacroblocks(macroblocks)
    % Get the size of the macroblocks cell array
    [numRows, numCols] = size(macroblocks);

    % Calculate the size of the original image
    macroblockSize = size(macroblocks{1, 1}, 1);
    imgLength = numCols * macroblockSize;
    imgHeight = numRows * macroblockSize;

    % Initialize the decoded image matrix
    Deco_Image = zeros(imgHeight, imgLength, 'uint8');

    % Reconstruct the original image from macroblocks
    for i = 1:numRows
        for j = 1:numCols
            % Get the current macroblock
            macroblock = macroblocks{i, j};

            % Determine the position to place the macroblock in the decoded image
            rowStart = (i - 1) * macroblockSize + 1;
            rowEnd = rowStart + macroblockSize - 1;
            colStart = (j - 1) * macroblockSize + 1;
            colEnd = colStart + macroblockSize - 1;

            % Place the macroblock in the decoded image
            Deco_Image(rowStart:rowEnd, colStart:colEnd) = macroblock;
        end
    end
end
