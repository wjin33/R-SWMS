% Function to read output files from Partrace savconxxxxxx
% The argument of the function must be the path to the file
%%

function savcon=read_savcon(file)
fid=fopen(file,'r'); %open the file
if fid == -1 %return value of -1 if file is not found
   savcon=-1;
   return;
end
C=textscan(fid,'%f %f %f %f','headerlines',3); %read file
for i=1:length(C)
    savcon(:,i)=C{i}; %create variable savcon and assign values from C
end
fclose(fid); %close file
end