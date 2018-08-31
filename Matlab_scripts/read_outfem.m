% Function to read output file outfem.xx
% Input variable file is the path to the outfem.xx file
%%

function outfem=read_outfem(file)
fid=fopen(file,'r'); %open file
if fid == -1 %if file is not found, assign a value of -1 to outroot variable
   outfem=-1;
   return;
end

% write as many %f in the textscan function as columns there are in your
% outfem.xx file

C=textscan(fid,'%f %f %f %f %f %f %f %f %f %f','headerlines',8);
for i=1:length(C)
    outfem(:,i)=C{i};
end
fclose(fid); %close file
end