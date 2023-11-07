function Deco_macroImage = decode_image(data,range,dcDict,acDict)


% data = DATA;
% range = SIZE;
% dcDict = DC_dict;
% acDict = AC_dict;
% w=imgX;
% h=imgY;


%% data partition

dcData=data(1:range);
acData =data(range+1:end);


%% DC huffman decoding
Deco_DC_DiffData = huffmandeco(dcData,dcDict);

%% inverse diffrential
Deco_DC_Val = inv_differential(Deco_DC_DiffData);

%% AC huffman decoding
Deco_AC_RLData = huffmandeco(acData,acDict);
% inverse run length
Deco_AC_Val = inv_runlength(Deco_AC_RLData);

%% inverse AC/DC extraction fuctions
Deco_QuantDCT = inv_Extract(Deco_DC_Val,Deco_AC_Val);

%% inverse quantizer
Deco_DCT_Co = inv_quantize(Deco_QuantDCT);

%% inverse DCT transform

Deco_macroImage= inv_DCT(Deco_DCT_Co);


end







