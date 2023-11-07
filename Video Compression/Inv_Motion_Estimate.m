function output = Inv_Motion_Estimate(Mv,res,ref)

%result --> output = mA     ; mA,pR
%ref = pR;
%res = Dec_RES;
%Mv = MV;

global macroblockSize 

[mX,mY]=size(res);
output=cell(mX,mY);

%type conversion
ref=int16(ref);


for ni=1:mX
    for nj=1:mY
        
        %block selection
        xB=((ni-1)*macroblockSize)+1; %starting indexes
        yB=((nj-1)*macroblockSize)+1;
        tRes = int16(cell2mat(res(ni, nj)));
        
        %motion vector
        tMv= cell2mat(Mv(ni,nj));
       
       
        %extracting data from previous frame
        xS =xB+tMv(1);
        yS =yB+tMv(2);
        xL = xS+macroblockSize-1; %7=N-1
        yL = yS+macroblockSize-1; %7=N-1
        rBlock = int16(ref(xS:xL,yS:yL));
        
        %correction
        cBlock = tRes + rBlock;
        
        %end of one calculation
        output(ni,nj) =   mat2cell(cBlock,macroblockSize,macroblockSize);
          
    end
end

end
