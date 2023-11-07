function dcValues = extractDCValues(DCT_Con)
    % Initialize an array to store the DC values
    dcValues = zeros(size(DCT_Con));

    % Extract the DC values from the DCT converted macroblocks
    for i = 1:size(DCT_Con, 1)
        for j = 1:size(DCT_Con, 2)
            macroblockDCT = DCT_Con{i, j};
            dcValues(i, j) = macroblockDCT(1, 1);
        end
    end
end


