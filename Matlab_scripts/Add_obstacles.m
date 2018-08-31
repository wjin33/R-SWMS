%Add obstacles for grid & nodes

Nodes=read_nodes('../in/nodesO.in');
Element=read_grid('../in/gridO.in');

Nodes_o=Nodes;
Element_o=Element;

%%% Consider gravity:[xmin xmax ymin ymax zmin zmax]
obstacles=[-2 3 -0.26 0.26 -8 -4;
             2 6 -0.26 0.26 -13 -10;
            -5  0 -0.26 0.26 -19 -15;];

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
% remove
Nodes(TFall,:) = [] ;
end

% check the removed node ID
DInd=setdiff(Nodes_o(:,1),Nodes(:,1));
n=size(DInd,1);

% Remove the elements with nodes been removed
for i=1:n
    TF1 = Element(:,2) == DInd(i) | Element(:,3) == DInd(i) ;
    TF2 = Element(:,4) == DInd(i) | Element(:,5) == DInd(i) ;
    TF3 = Element(:,6) == DInd(i) | Element(:,7) == DInd(i) ;
    TF4 = Element(:,8) == DInd(i) | Element(:,9) == DInd(i) ;
    TFall = TF1 | TF2 | TF3 | TF4;
    Element(TFall,:) = [] ;
end

nPt=size(Nodes,1);
Conectivity=Element(:,2:9);

% Repalce the node number in connectivity matrix with updated ones
for i=1:nPt
    if i ~= Nodes(i,1)
        Conectivity(Conectivity==Nodes(i,1))=i;
    end
end

Element(:,2:9)=Conectivity;
Nodes(:,1)=1:nPt;
nEle = size(Element,1);

EleTran=Element(:,1);
Element(:,1)=1:nEle;



fileID = fopen('../in/grid.in','w');
fprintf(fileID,'***** GRID ELEMENTS INFORMATION *****\n');
fprintf(fileID,' \n');
fprintf(fileID,'     nPt    nElm\n');
fprintf(fileID,'     %d     %d\n',nPt,nEle);
fprintf(fileID,' \n');
fprintf(fileID,'     nx     ny     nz     nex     ney     nez       dx          dy          dz\n');
fprintf(fileID,'     101       2     101     100       1     100  5.0000E-01  5.0000E-01  5.0000E-01\n');
fprintf(fileID,' \n');
fprintf(fileID,'* Element Information *\n');
fprintf(fileID,'      iE       i      j      k      l      m      n     o     p    sub     -----A-----  --C--\n');
for i=1:nEle
    fprintf(fileID,'%8d%8d%8d%8d%8d%8d%8d%8d%8d%5d%5d%2d%2d%2d%2d%2d%4d%2d%2d\n',Element(i,:));  
end    
fclose(fileID);



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


fileID = fopen('../in/obstacles.in','w');
fprintf(fileID,'***** OBSTACLES INFORMATION *****\n');
fprintf(fileID,' \n');
fprintf(fileID,'nobstacles\n');
fprintf(fileID,'     %d\n',nobstacles);
fprintf(fileID,' \n');
fprintf(fileID,'  xminObs       xmaxObs       yminObs	    ymaxObs	     zminObs	   zmaxObs\n');
for i=1:nobstacles
    fprintf(fileID,'%12.4E %12.4E %12.4E %12.4E %12.4E %12.4E\n',obstacles(i,:));  
end 
fprintf(fileID,' \n');
fprintf(fileID,'* Element Transform Info *\n');
for i=1:nEle
    fprintf(fileID,'%8d\n',EleTran(i));  
end    
fclose(fileID);







