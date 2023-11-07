function decMv = decode_MV(mvData,mvDict)


%mvData = Enc_Mv_HuffmanData;
%mvDict = Mv_dict;

%w=imgX;
%h=imgY;

%N=8;

global macroblockSize
global imgLength
global imgHeight

nX=ceil(imgLength/macroblockSize);
nY=ceil(imgHeight/macroblockSize);

decMv=cell(nX,nY);

%% MV huffman decoding
Dec_DC_MvData = huffmandeco(mvData,mvDict);
n=1;
for i=1:nX
    for j=1:nY
        tMv=Dec_DC_MvData(n:n+1);
        decMv(i,j)=mat2cell(tMv,1,2);
        n=n+2;
    end
end

end







