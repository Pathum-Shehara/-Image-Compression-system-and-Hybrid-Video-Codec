function output = inv_DCT(input)

N = 8;
[x, y] = size(input);
output = cell(x,y);

    for i = 1:1:x
        for j = 1:1:y
            %inverse 2-D discrete cosine transform
            imgVal = idct2(cell2mat(input(i,j))); 
            %saving image in a cell array
            output(i,j) = mat2cell(imgVal,N,N);
           
        end
    end

end

