function save_data(data,id)

%if need be use this no remove spaces in the data stream
 %str='';
 
 %for i=1:length(data)
     %str=strcat(str,num2str(data(i)));
 %end
 
fid = fopen(id,'w'); 
fprintf(fid,num2str(data)); 
fclose(fid); 

end
