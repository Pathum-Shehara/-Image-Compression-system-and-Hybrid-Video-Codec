function  Rate_optimize(input,R_Rate)


global Qlevel


R=[];
D=[];

%image reading
pI1 = padding(input);
mI1 = macroblocks(pI1);

%%
testQ = [1 2 4 10 20 25 40];


j=1;
k=2;%start from the second value of temp
r=inf;
expFlag=0;
ftFlag=0;
while 1 %testQ length + 1
    
    if(r > R_Rate)
        if(j<=length(testQ) && ftFlag==0)    %init q val assigin
           %disp('Inital Q')
            Qlevel = testQ(j);
            j=j+1;
        elseif(ftFlag == 1 || k==10) 
            Qlevel = temp(k-2);
            %disp('End of Fine tuning')
            break;
       
        elseif(ftFlag == 0)     %extraploation, this is correct
            expFlag = 1;
            disp('Extraplolating Q')
            Qlevel = Qlevel+5; 
          
          
        end
        
    else% r < R_Rate % fine tuing for extrpolation and end of extraploation
        
        if(j==2)
            %disp('new')
            break
        
        elseif(expFlag == 0 && k<10)
            ftFlag = 1;
            temp = linspace(testQ(j-1),testQ(j-2),10);
            %disp('Fine tuning')
            Qlevel = temp(k);
            
            k=k+1;
            
        elseif(expFlag == 1) 
            %disp('End of Extrapolating')
            break;
            
        elseif(k==10) 
            %disp('End of Fine tuning')
            break;
        
        end
    end
    
    
    %initalizing
    Data=[];
    MV_Data=[];
  
    % I
    
    [Data,Range,DC_dict,AC_dict] = encode_image(mI1);
    
    Dec_Image = decode_image(Data,Range,DC_dict,AC_dict);
    
    Rx_Ref = cell2mat(Dec_Image);
    IMG1 = inv_padding(Dec_Image);
     
    % simply considering only data stream
    r = (length(Data))/1000;
    R =[R r]; %rate in kBits per frame 

    D = [D psnr(IMG1,input)];
    
    
end
 
%%

% figure;
% plot(1./D,R,'o-');
% xlabel('Distortion in (1/PSNR)');
% ylabel('Data Rate in kbpf');

txt=['Final Qlevel   = ',num2str(Qlevel)];
disp(txt);

end
