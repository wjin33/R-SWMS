Nodes=read_nodes('../in/nodesO.in');
% Element=read_grid('../in/gridO.in');

Nodes_o=Nodes;
% Element_o=Element;

%%% Consider gravity:[xmin xmax ymin ymax zmin zmax]
obstacles=[-2 3 -0.35 0.35 -8 -4;];
%              6 11 -0.25 0.25 -12 -7;
%             -4  4 -0.25 0.25 -25 -22;];

ad_obstacles=obstacles;
ad_obstacles(:,1:2:5) = obstacles(:,1:2:5) + 0.01;
ad_obstacles(:,2:2:6) = obstacles(:,2:2:6) - 0.01;

nobstacles=size(obstacles,1);
for ind=1:nobstacles
% Specify conditions
TF1 = Nodes(:,3) >= ad_obstacles(ind,1) & Nodes(:,3) <= ad_obstacles(ind,2) ;
TF2 = Nodes(:,4) >= ad_obstacles(ind,3) & Nodes(:,4) <= ad_obstacles(ind,4) ;
TF3 = Nodes(:,5) >= ad_obstacles(ind,5) & Nodes(:,5) <= ad_obstacles(ind,6) ;
% combine them
TFall = TF1 & TF2 & TF3;
% change material number
Nodes(TFall,2) = [ind+1] ;
sum(TFall)
end

%check
sum(Nodes(:,2))

nPt=size(Nodes,1);
fileID = fopen('../in/nodes.in','w');
fprintf(fileID,' \n');
fprintf(fileID,' \n');
fprintf(fileID,' \n');
fprintf(fileID,' \n');
fprintf(fileID,' \n');
fprintf(fileID,' \n');
fprintf(fileID,'Node# Mater.#    x           y           z           h           C\n');
for i=1:nPt
    fprintf(fileID,'%7d%8d%12.4E%12.4E%12.4E%12.4E%12.4E\n',Nodes(i,:));  
end    
fclose(fileID);