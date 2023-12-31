function Dec_QuantDCT = inv_Extract(Deco_DC_Val, Dec_AC_Val)
    % Inverse DC Extraction
    global macroblockSize
    global imgLength
    global imgHeight
    
    macroblockSize = 8;

    x = ceil(imgLength / macroblockSize);
    y = ceil(imgHeight / macroblockSize);

    % Cell array creation
    Dec_QuantDCT = cell(x, y);
    k = 1;

    % Assigning AC values
    temp = reshape(Dec_AC_Val, [], x * y); % Each column represents one cell

    % Assigning DC values
    for i = 1:x
        for j = 1:y
            dc = Deco_DC_Val(k);
            b = temp(:, k);
            block = [dc    b(1)  b(5)  b(6)  b(14) b(15) b(27) b(28); 
                     b(2)  b(4)  b(7)  b(13) b(16) b(26) b(29) b(42);
                     b(3)  b(8)  b(12) b(17) b(25) b(30) b(41) b(43);
                     b(9)  b(11) b(18) b(24) b(31) b(40) b(44) b(53);
                     b(10) b(19) b(23) b(32) b(39) b(45) b(52) b(54);
                     b(20) b(22) b(33) b(38) b(46) b(51) b(55) b(60);
                     b(21) b(34) b(37) b(47) b(50) b(56) b(59) b(61);
                     b(35) b(36) b(48) b(49) b(57) b(58) b(62) b(63)];

            Dec_QuantDCT{i, j} = block;
            k = k + 1;
        end
    end
end
