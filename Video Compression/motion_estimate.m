function [Mv,Res] = motion_estimate(macro,ref)

%ref = pR;
%macro = mA;

[mX,mY]=size(macro);
[width,height] =size(ref);

%search area (2p+1)*(2p+1) with p = 7; 

global macroblockSize
global P 

Mv=cell(mX,mY);
Res=cell(mX,mY);

%type conversion
ref=int16(ref);


for i=1:mX
    for j=1:mY
        
        %block selection
        tBlock = int16(cell2mat(macro(i,j))) ;
        
        %initializing SAD
        SAD=0;
        count=1;
        
        %Search area selection
        
        xB=((i-1)*macroblockSize)+1; %starting indexes
        yB=((j-1)*macroblockSize)+1;
        for k=-P:P
            for l=-P:P
               %start and last indexes of search block
               xS =xB+k;
               yS =yB+l;
               xL = xS+7; %7=N-1
               yL = yS+7; %7=N-1
               
               if(xS>=1 && yS>=1 && xL <= width && yL <= height )
                    rBlock = ref(xS:xL,yS:yL);
                    tVal = sum(sum(abs(tBlock-rBlock)));
                    
                    if(count==1)
                        SAD = tVal;
                        tMv = [k,l];
                        tRes = tBlock-rBlock;
                        count=count+1;
                    elseif(SAD > tVal)
                        SAD = tVal;
                        tMv = [k,l];
                        tRes = tBlock-rBlock;
                    end     
               end
            end   
        end
        %end of one calculation
        
       % x=tMv;
        %y=tRes;
        
        Mv(i,j) =   mat2cell(tMv,1,2);
        Res(i,j) =   mat2cell(tRes,macroblockSize,macroblockSize);
           
    end
end


end
