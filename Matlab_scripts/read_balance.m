% Function to read output file balance.out
% Input variable file is the path to the outRoo1.xx file
%%
function balance=read_balance(file)

fid=fopen(file,'r'); %open file

C=textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f','headerlines',4); %read file
for i=1:length(C)
    balance(:,i)=C{i}; %create variable balance with data from C
end
C=textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f ');

while isempty(C{1})~=1
    for i=1:length(C)
        balancebis(:,i)=C{i};
    end
    balance=[balance;balancebis];
    C=textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f ');
    clear balancebis
end

compteur=1;
for line=1:size(balance,1)
    if isnan(balance(line,end))~=1
        balancebis(compteur,:)=balance(line,:);        
        compteur = compteur+1 ;
    end
end

if exist('balancebis')~=0
balance=balancebis;
end
fclose(fid);
end