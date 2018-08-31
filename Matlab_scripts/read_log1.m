% Function to read output file log1
% First argument of the function is the path to the file that is read
% Second argument of the function is the number of columns in file log1.
% Usual number is 6, it should be set to 10 when sorption and root solute
% uptake is modelled. In any case, check your log1 output files.
%%
function log1=read_log1(file,ncl) 
if nargin <2
   ncl=6;
end
fid=fopen(file,'r'); %open file
format='';
for i=1:ncl
   format=[format,'%f ']; %write as many %f as columns there are
end
C=textscan(fid,format,'headerlines',1); %read file with textscan
for i=1:length(C)
    log1(:,i)=C{i}(~isnan(C{i})); %create vairable log1 and assign values from C
end
C=textscan(fid,format);

while isempty(C{1})~=1
    for i=1:length(C)
        log1bis(:,i)=C{i};
    end
    log1=[log1;log1bis];
    C=textscan(fid,format);
end

log1=log1(isnan(log1(:,2))~=1,:);
fclose(fid); %close file
end