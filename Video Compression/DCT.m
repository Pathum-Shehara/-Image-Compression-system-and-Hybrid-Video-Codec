function dctMacroblocks = DCT_Con(macroBlocks)
    % Get the size of macroblocks
    [numRows, numCols] = size(macroBlocks);

    % Initialize cell array to store DCT transformed values
    dctMacroblocks = cell(numRows, numCols);

    % Compute DCT for each macroblock
    for i = 1:numRows
        for j = 1:numCols
            % Apply DCT transform to the current macroblock
            dctMacroblock = dct2(macroBlocks{i, j});

            % Store the DCT transformed values in the cell array
            dctMacroblocks{i, j} = dctMacroblock;
        end
    end
end

