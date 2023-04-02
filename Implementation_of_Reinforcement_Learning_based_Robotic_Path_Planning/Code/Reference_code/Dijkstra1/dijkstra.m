%tic
clc
clear all
close all
% A = [0 3 9 0 0 0 0 ;
%      0 0 0 7 1 0 0 ; 
%      0 2 0 7 0 0 0 ; 
%      0 0 0 0 0 2 8 ;
%      0 0 4 5 0 9 0 ; 
%      0 0 0 0 0 0 4 ; 
%      0 0 0 0 0 0 0 ];

A= [ 0 500 0 0 300 100 0 0 0 0 0 0 0 0 0 0 ;
     800 0 500 0 0 300 100 0 0 0 0 0 0 0 0 0 ;
     0 800 0 500 0 0 300 100 0 0 0 0 0 0 0 0 ;
     0 0 800 0 0 0 0 300 0 0 0 0 0 0 0 0 ;
     800 0 0 0 0 500 0 0 300 100 0 0 0 0 0 0 ;
     0 800 0 0 800 0 500 0 0 300 100 0 0 0 0 0 ;
     0 0 800 0 0 800 0 500 0 0 300 100 0 0 0 0 ;
     0 0 0 800 0 0 800 0 0 0 0 300 0 0 0 0 ;
     0 0 0 0 800 0 0 0 0 500 0 0 300 100 0 0 ;
     0 0 0 0 0 800 0 0 800 0 500 0 0 300 100 0 ;
     0 0 0 0 0 0 800 0 0 800 0 500 0 0 300 100 ;
     0 0 0 0 0 0 0 800 0 0 800 0 0 0 0 300 ;
     0 0 0 0 0 0 0 0 800 0 0 0 0 500 0 0 ;
     0 0 0 0 0 0 0 0 0 800 0 0 800 0 500 0 ;
     0 0 0 0 0 0 0 0 0 0 800 0 0 800 0 500 ;
     0 0 0 0 0 0 0 0 0 0 0 800 0 0 800 0 ];

% obstacle at node 6 
% A= [ 0 500 0 0 300 0 0 0 0 0 0 0 0 0 0 0 ;
%      800 0 500 0 0 0 100 0 0 0 0 0 0 0 0 0 ;
%      0 800 0 500 0 0 300 100 0 0 0 0 0 0 0 0 ;
%      0 0 800 0 0 0 0 300 0 0 0 0 0 0 0 0 ;
%      800 0 0 0 0 0 0 0 300 100 0 0 0 0 0 0 ;
%      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ;
%      0 0 800 0 0 0 0 500 0 0 300 100 0 0 0 0 ;
%      0 0 0 800 0 0 800 0 0 0 0 300 0 0 0 0 ;
%      0 0 0 0 800 0 0 0 0 500 0 0 300 100 0 0 ;
%      0 0 0 0 0 0 0 0 800 0 500 0 0 300 100 0 ;
%      0 0 0 0 0 0 800 0 0 800 0 500 0 0 300 100 ;
%      0 0 0 0 0 0 0 800 0 0 800 0 0 0 0 300 ;
%      0 0 0 0 0 0 0 0 800 0 0 0 0 500 0 0 ;
%      0 0 0 0 0 0 0 0 0 800 0 0 800 0 500 0 ;
%      0 0 0 0 0 0 0 0 0 0 800 0 0 800 0 500 ;
%      0 0 0 0 0 0 0 0 0 0 0 800 0 0 800 0 ];



s =input('Enter the id of source node in the grid ');  %Starting node
d =input('Enter the id of destination node in the grid ');    %Destination node
numberof_obstacles = input('Enter the number of obstcles in the grid ');

%function [e L] = dijkstra(A,s,d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=0:4;
Y=0:4;
figure('Color',[0.8 0.8 0.8]);
  plot(X,Y,'c');
  set(gca,'Color','c')
  xlabel('Distance covered along x-direcction')
ylabel('Distance covered along y-direcction')
grid on
hold on
set(gca,'XTick',[0 1 2 3 4],'YTick',[0 1 2 3 4]);
[stx sty] = getcoordinate(s);
plot(stx,sty,'o');
hold on
[dstx dsty] = getcoordinate(d);
plot(dstx,dsty,'o');
hold on

if (numberof_obstacles > 0)        % obstacle is present

% Obstacle plotting and Weight updation

for i=1:numberof_obstacles
     obstaclenode(i) = input(['Enter the node id  at which ' num2str(i) ' th obstacle is placed ']);
    [ x(i) y(i)] = getcoordinate(obstaclenode(i));
%      x(i)=input(['Enter the x coordinate of ' num2str(i) ' th obstacle ']);
%      y(i)=input(['Enter the y coordinate of ' num2str(i) ' th obstacle ']);
     plot(x(i),y(i),'-*');
     hold on
% updating the Graph matrix based on the position of obstacle

for j= 1:1:16
    A(obstaclenode(i),j) = 0;
    A(j,obstaclenode(i)) = 0;
end

end
end
%A
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if s==d
    e=0
    L=[s]
else

A = setupgraph(A,inf,1);

if d==1
    d=s;
end
A=exchangenode(A,1,s);

lengthA=size(A,1);
W=zeros(lengthA);
for i=2 : lengthA
    W(1,i)=i;
    W(2,i)=A(1,i);
end

for i=1 : lengthA
    D(i,1)=A(1,i);
    D(i,2)=i;
end

D2=D(2:length(D),:);
L=2;
while L<=(size(W,1)-1)
    L=L+1;
    D2=sortrows(D2,1);
    k=D2(1,2);
    W(L,1)=k;
    D2(1,:)=[];
    for i=1 : size(D2,1)
        if D(D2(i,2),1)>(D(k,1)+A(k,D2(i,2)))
            D(D2(i,2),1) = D(k,1)+A(k,D2(i,2));
            D2(i,1) = D(D2(i,2),1);
        end
    end
    
    for i=2 : length(A)
        W(L,i)=D(i,1);
    end
end
if d==s
    L=[1];
else
    L=[d];
end
e=W(size(W,1),d)
L = listdijkstra(L,W,s,d)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% X=0:4;
% Y=0:4;
% figure('Color',[0.8 0.8 0.8]);
%   plot(X,Y,'c');
%   set(gca,'Color','c')
%   xlabel('Distance covered along x-direcction')
% ylabel('Distance covered along y-direcction')
% grid on
% hold on
% set(gca,'XTick',[0 1 2 3 4],'YTick',[0 1 2 3 4]);
% [stx sty] = getcoordinate(s);
% plot(stx,sty,'o');
% hold on
% [dstx dsty] = getcoordinate(d);
% plot(dstx,dsty,'o');
% hold on

% path drawing
pathnodes = numel(L);
px = stx;
py = sty;
for i=pathnodes:-1:1
     [npx npy] = getcoordinate(L(i));
%      npx
%      npy
     x1 = [px npx];
     y1 = [py npy];
     plot(x1,y1,'LineWidth',4);            
     hold on
     px = npx;
     py = npy;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc