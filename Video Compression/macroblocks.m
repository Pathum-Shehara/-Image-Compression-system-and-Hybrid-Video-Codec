function macro = macroblocks(inputImage)

global macroblockSize
global imgLength
global imgHeight

rowDim=ceil(imgLength/macroblockSize);
colDim=ceil(imgHeight/macroblockSize);

rowVec=macroblockSize*ones(1,rowDim);
colVec=macroblockSize*ones(1,colDim);

macro=mat2cell(inputImage,rowVec,colVec);

end