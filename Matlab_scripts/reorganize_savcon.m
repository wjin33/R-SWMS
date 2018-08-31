% Function to reorganize savcon file so that the elements are in the same
% order as in R-SWMS

% First argument corresponds to the original savcon file that is read
% a is the number of elements in x
% b is the number of elements in y
% c is the number of elements in z
%%

function savcon = reorganize_savcon(savconoriginal,a,b,c)

    savcon=zeros(size(savconoriginal));
    
    planeXY=a*b; %calculates the number of elements per plane XY
    num_planes=c; %number of planes in z
           
    for j=1:num_planes
        savcon((j*planeXY)-(planeXY-1):(j*planeXY),:)=savconoriginal(((num_planes-j)*planeXY)+1:((num_planes-j)*planeXY)+planeXY,:);
    end

end