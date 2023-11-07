function  Qlty_optimize(input,pVal)


global Qlevel

D=[];

%image reading
pI1 = padding(input);
mI1 = macroblocks(pI1);

%%
testQ = [1 2 4 9 20 25 40];

j=1;
x=inf;


while 1 %testQ length + 1
    
    if(pVal<x && j<=length(testQ))
        %disp('selecting')
        Qlevel = testQ(j);
        j=j+1;
    elseif(j<=length(testQ))
        %disp('selected')
        Qlevel=testQ(j-2);
        break
    else
        %disp('last Q selected')
        Qlevel=testQ(end);
        break
    end
    
    %initalizing
    Data=[];
    MV_Data=[];
  
    % I
    
    [Data,Range,DC_dict,AC_dict] = encode_image(mI1);
    
    Dec_Image = decode_image(Data,Range,DC_dict,AC_dict);
    
    Rx_Ref = cell2mat(Dec_Image);
    IMG1 = inv_padding(Dec_Image);
     
    x = psnr(IMG1,input);
    D = [D x];
    
    
end
 

%%

txt=['Max posiible PSNR value = ',num2str(D(1)),' Final Qlevel   = ',num2str(Qlevel)];
disp(txt);

end

