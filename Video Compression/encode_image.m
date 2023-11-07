function [output,range,DC_dict,AC_dict] = encode_image(image)

%taking input image as macro block

%image=RES;

global AC_RL_EncoData;

%% DCT conversion
DCT_Conv = DCT(image);

%% Quantization
%QLevel = 1; % this can be 1,4,6 like value
Quant_DCT = Quantize(DCT_Conv);

%% DC extraction
DC_Val = DC_Extract(Quant_DCT);

%% AC extraction   
AC_Val = AC_Extract(Quant_DCT);

%% DC encoding - differential 
DC_DiffEncoData = differential(DC_Val);

%% DC huffman coding
% DC sybol probability calculation 
[DC_prob,DC_symbol] = symbol_prob(DC_DiffEncoData);
% huffman codebook generation
DC_dict = huffmandict(DC_symbol, DC_prob);
% huffman encoding
Enco_DC_DiffHuffmanData= huffmanenco(DC_DiffEncoData,DC_dict);

% saving data
save_data(Enco_DC_DiffHuffmanData,'DC bit stream.txt')

%% AC encoding - run length
AC_RL_EncoData = run_length(AC_Val);

%% AC huffman coding
% AC sybol probability calculation 
[AC_prob,AC_symbol] = symbol_prob(AC_RL_EncoData);
% huffman codebook generation
AC_dict = huffmandict(AC_symbol, AC_prob);
% huffman encoding
Enco_AC_RLHuffmanData= huffmanenco(AC_RL_EncoData,AC_dict);

% saving data
save_data(Enco_AC_RLHuffmanData,'AC bit stream.txt')

output=[Enco_DC_DiffHuffmanData,Enco_AC_RLHuffmanData];
range=length(Enco_DC_DiffHuffmanData);

end

