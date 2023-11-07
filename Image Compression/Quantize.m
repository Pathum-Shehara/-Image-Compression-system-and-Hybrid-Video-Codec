function quantizedDCT = Quantize(DCT_Conv)

    global QLevel 
    
    % Get the size of the DCT converted macroblocks
    [numRows, numCols] = size(DCT_Conv);

    % Initialize cell array to store the quantized macroblocks
    quantizedDCT = cell(numRows, numCols);

    % Define the quantization matrix
    quantizationMatrix = QLevel* [16 11 10 16 24 40 51 61;
                                 12 12 14 19 26 58 60 55;
                                 14 13 16 24 40 57 69 56;
                                 14 17 22 29 51 87 80 62;
                                 18 22 37 56 68 109 103 77;
                                 24 35 55 64 81 104 113 92;
                                 49 64 78 87 103 121 120 101;
                                 72 92 95 98 112 100 103 99];

    if(QLevel==0)
        Q=ones(8,8);
    end
                                
    % Apply quantization to each macroblock
    for i = 1:numRows
        for j = 1:numCols
            % Get the DCT transformed macroblock
            macroblockDCT = DCT_Conv{i, j};
            
            % Apply quantization by dividing element-wise with the quantization matrix
            quantizedMacroblock = round(macroblockDCT ./ quantizationMatrix);
            
            % Store the quantized macroblock in the cell array
            quantizedDCT{i, j} = quantizedMacroblock;
        end
    end
end


