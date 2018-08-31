%draw_root
% plot the root system in white (usually on a prevsiouly dran FEM 3D plot)
% Javaux, M., 2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function draw_root(rootsys,color,continu)


[info_tip,seg_info,age,info_grw,n_br,n_tip,n_root,xyroot,~]=read_rootsys(rootsys);
Xr=seg_info(:,2);Yr=seg_info(:,3);Zr=seg_info(:,4);
Xg=info_tip(:,2);Yg=info_tip(:,3);Zg=info_tip(:,4);
diam=seg_info(:,9)./seg_info(:,8);

if (max(info_tip(:,6))==13)
   info_tip(info_tip(:,6)<12,6)=1;
   info_tip(info_tip(:,6)>=12,6)=2;
elseif max(info_tip(:,6))==10
   info_tip(info_tip(:,6)<9,6)=1;
   info_tip(info_tip(:,6)>=9,6)=2; 
elseif max(info_tip(:,6))==5
   info_tip(info_tip(:,6)<=2,6)=1;
   info_tip(info_tip(:,6)>=3 & info_tip(:,6)<=5,6)=2 ; 
elseif max(info_tip(:,6))==4
   info_tip(info_tip(:,6)<3,6)=1;
   info_tip(info_tip(:,6)>=3 & info_tip(:,6)<4,6)=2 ; 
   info_tip(info_tip(:,6)>=4,6)=3 ;  
elseif max(info_tip(:,6))==7 || max(info_tip(:,6))==6      
   info_tip(info_tip(:,6)<2,6)=1;
   info_tip(info_tip(:,6)>=2 & info_tip(:,6)<4,6)=2 ;
   info_tip(info_tip(:,6)>=4 & info_tip(:,6)<8,6)=3 ;  
end

if nargin <2
   color=0;
    map=zeros(length(unique(info_tip(:,6))),3); 
   
else
    map=flipud(jet(length(unique(info_tip(:,6))))); 
end

if nargin <3
   lcontinu=0;
else
   lcontinu=1;
   dim_x=continu(1);
   dim_y=continu(2);
end
    


orders=(unique(info_tip(:,6)));
                     
hold on;
%relates tip and brenches
switch lcontinu
    case 0
for in=1:n_br
    OK=find(seg_info(:,7)==in);
    brench(1,:)=[Xr(OK)',Xg(in)];
    brench(2,:)=[Yr(OK)',Yg(in)];
    brench(3,:)=[Zr(OK)',Zg(in)];
    num=[seg_info(OK,1)',info_tip(in,1)];
    matseg=seg_info(OK,:);
    %find embranchment
    if min(seg_info(OK,5))~=0 %not connected to the seed
         OKbrench=find(seg_info(matseg(:,5),7)~=in);
         ibrench=matseg(OKbrench,5);
         brench(1:3,2:end+1)=brench;
         brench(1:3,1)=[Xr(ibrench);Yr(ibrench);Zr(ibrench)];
         num(2:end+1)=num;
         num(1)=ibrench;
    elseif in==1 & sum(brench(:,1)-brench(:,2))==0 %Seed
        plot3(brench(1,1),brench(2,1),brench(3,1),'og');hold on;
        brench(:,1)=[];
        num(1)=[];
    end
    for j=1:n_root
        xi=brench(1,:)+xyroot(j,2);
        yi=brench(2,:)+xyroot(j,3);
        zi=brench(3,:);
            l_line(in)=line(xi,yi,zi,...
                'color',map(find(orders==info_tip(in,6)),:),'linewidth',1.2);
            hold on;%
    end
%     
    clear brench;clear num;
end
   
    case 1
        
for in=1:n_br
    OK=find(seg_info(:,7)==in);
    brench(1,:)=[Xr(OK)',Xg(in)];
    brench(2,:)=[Yr(OK)',Yg(in)];
    brench(3,:)=[Zr(OK)',Zg(in)];
    num=[seg_info(OK,1)',info_tip(in,1)];
    matseg=seg_info(OK,:);
    %find embranchment
    if min(seg_info(OK,5))~=0 %not connected to the seed
         OKbrench=find(seg_info(matseg(:,5),7)~=in);
         ibrench=matseg(OKbrench,5);
         brench(1:3,2:end+1)=brench;
         brench(1:3,1)=[Xr(ibrench);Yr(ibrench);Zr(ibrench)];
         num(2:end+1)=num;
         num(1)=ibrench;
    elseif in==1 & sum(brench(:,1)-brench(:,2))==0 %Seed
        plot3(brench(1,1),brench(2,1),brench(3,1),'og');hold on;
        brench(:,1)=[];
        num(1)=[];
    end
    for j=1:n_root
        xi=brench(1,:)+xyroot(j,2);
        tr_x=ceil((xi-dim_x./2)./(dim_x));
        xi=-tr_x*dim_x/2+(xi-(tr_x*dim_x/2));
        yi=brench(2,:)+xyroot(j,3);
        tr_y=ceil((yi-dim_y./2)./(dim_y));
        yi=-tr_y*dim_y/2+(yi-(tr_y*dim_y/2));
        zi=brench(3,:);
        diffe=abs(diff(tr_x))+abs(diff(tr_y));
        pos=[0,find(diffe~=0),length(tr_x)];
        for iii=1:length(pos)-1
            l_line(in)=line(xi(pos(iii)+1:pos(iii+1)),yi(pos(iii)+1:pos(iii+1)),zi(pos(iii)+1:pos(iii+1)),...
                'color',map(find(orders==info_tip(in,6)),:),'linewidth',1.2);
            hold on;%
        end
    end
%     
    clear brench;clear num;
end        
        
end
hold off;grid on;axis equal;%tight
xlabel('X');ylabel('Y');zlabel('Z');
view([45 25])

if color ~= 0
for i=1:length(orders)
    temp=find(info_tip(:,6)==orders(i));
    position(i)=temp(1);
    legende{i}=['Order #',num2str(orders(i))];
end

legend(l_line(position),legende)

end

end
