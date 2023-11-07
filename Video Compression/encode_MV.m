function [Enc_Mv_HuffmanData,Mv_dict] = encode_MV(Mv)


%Mv=MV;

[nX,nY]=size(Mv);
data_Mv=[];

for i=1:nX
    for j=1:nY
        tMv=cell2mat(Mv(i,j));
        data_Mv=[data_Mv tMv];
    end
end

%% DC huffman coding
% DC sybol probability calculation 
[Mv_prob,Mv_symbol] = symbol_prob(data_Mv);
% huffman codebook generation
Mv_dict = huffmandict(Mv_symbol, Mv_prob);
% huffman encoding
Enc_Mv_HuffmanData= huffmanenco(data_Mv,Mv_dict);

% saving data
%SAVE_DATA(Enc_DC_diffHuffmanData,'DC bit stream.txt')

end




