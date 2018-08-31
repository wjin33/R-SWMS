% Function to read output files outRoo1.xx 
% Input variable file is the path to the outRoo1.xx file
%%

function outroot=read_outroot(file)
fid=fopen(file,'r'); %open file
if fid == -1 %if file is not found, assign a value of -1 to outroot variable
   outroot=-1;
   return;
end

% write as many %f in the textscan function as columns there are in your
% outRoo1.xx file, the number of columns will depend on the modules you use
% in R-SWMS (e.g. root solute uptake or not, salinity or not, etc)

C=textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','headerlines',7); 
for i=1:length(C)
    outroot(:,i)=C{i};
end
fclose(fid); %close file
end