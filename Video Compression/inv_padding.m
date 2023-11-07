function output = inv_padding(input)

global macroblockSize
global imgLength
global imgHeight

[x, y] = size(input);

for i = 1:1:x
    for j = 1:1:y
        x1 = cast(cell2mat(input(i,j)),'uint8');
        temp(i,j) = mat2cell(x1,macroblockSize,macroblockSize);
    
    end
end
padImage = cell2mat(temp);
output = imcrop(padImage,[0,0,imgHeight,imgLength]);

end

