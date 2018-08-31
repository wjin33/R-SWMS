function [info_tip,seg_info,age,info_grw,n_br,n_tip,n_root,xyroot,continu]=read_rootsys(pathl)
%read the initial root structure in/RootSys and save it in in/RootSys.mat.
%This contains the following variables
%   - info_tip(1:n_tip, 1:11): matrix with Root tip variables
%   - seg_info(1:n_seg,1:11): matrix with root segment variables
%   - info_grw(1:n_tip, 1:n_time_grw): matrix with growing time for apices.
%   - n_br: amount of branches
%   - n_tip: amount of root tips
%   - n_root: the number of seeds
%   - xyroot(1:n_root,1:3): the locations of the seeds
%
%Javaux, M., 2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear all;

file=pathl;

%     disp(['read root structure named ',file])

    %general features
    continu=dlmread('control.in','',[47 0 47 0]);
    time=dlmread(file,'',[1 0 1 0]);
    n_root=dlmread(file,'',[4 0 4 0]);
    xyroot=dlmread(file,'',[7 0 6+n_root 2]);
    nr=n_root+2;

    root=dlmread(file,'',[nr+7 0 nr+7 2]);
    soil=dlmread(file,'',[nr+10 0 nr+10 1]);
    n_axes=dlmread(file,'',[nr+13 0 nr+13 0]);
    n_br=dlmread(file,'',[nr+16 0 nr+16 0]);
    n_seg=dlmread(file,'',[nr+19 0 nr+19 0]);

    %read info on segments
    A=dlmread(file,'',[nr+23 0 nr+23+2*n_seg-1 9]);
    seg_info(:,1:10)=A(1:2:n_seg*2-1,:);
    seg_info(:,11)=A(2:2:n_seg*2,1);
    last=nr+23+2*n_seg-1;

    %read info on tips
    n_tip=dlmread(file,'',[last+3 0 last+3 0]);
    initial_tip=last+8;

    A2=dlmread(file,'',[initial_tip 0 initial_tip+2*n_tip-1 8]);
    info_tip(:,1:9)=A2(1:2:end-1,1:9);
    info_tip(:,10:11)=A2(2:2:end,1:2);
    info_grw=dlmread(file,'',[16 0 16 0]);
    clear A2;

    % for i=1:n_tip
    %     A2=dlmread(file,'',[initial_tip 0 initial_tip+1 8]);
    %     info_tip(i,1:9)=A2(1,1:9);
    %     info_tip(i,10:11)=A2(2,1:2);
    %     %nber of time growths
    %     n_time_grw=info_tip(i,11);
    %     n_line=ceil(n_time_grw/5);
    %     if n_line~=0
    %         if n_line==1
    %             B=dlmread(file,'',[initial_tip+2 0 initial_tip+1+n_line n_time_grw-1]);
    %         else
    %             B=dlmread(file,'',[initial_tip+2 0 initial_tip+1+n_line 4]);
    %             B=reshape(B,1,5*n_line);
    %         end
    %         info_grw(i,1:n_time_grw)=B(1:n_time_grw);
    %     else
    %         info_grw(i,1:n_time_grw)=0;
    %     end
    %     initial_tip=initial_tip+n_line+2;
    %     clear A2;clear B;
    % end

    %save
    fileout=['..\out\RootSysout.mat'];
    %save(fileout,'info_tip','seg_info','info_grw','n_br','n_tip','n_root','xyroot','continu');
    age=dlmread(file,'',[1,0,1,0]);