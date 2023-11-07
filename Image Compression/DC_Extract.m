function dcComponent = DC_Extract(QuantDCT)
    % Get the size of the quantized DCT macroblocks
    [numRows, numCols] = size(QuantDCT);

    % Initialize a vector to store the DC values
    dcComponent = zeros(1, numRows * numCols);

    % Extract the DC component from each quantized DCT macroblock
    index = 1; % Index to keep track of the position in the vector
    for i = 1:numRows
        for j = 1:numCols
            % Get the quantized macroblock
            quantizedMacroblock = QuantDCT{i, j};
            
            % Extract the DC component (top-left element)
            dcValue = quantizedMacroblock(1, 1);
            
            % Store the DC value in the vector
            dcComponent(index) = dcValue;
            index = index + 1;
        end
    end
end
