%PROJECT TOPIC: IMPLEMENTATION OF REINFORCEMENT LEARNING BASED ROBOTIC PATH PLANNING 
%SARSA ALGORITHM FOR 6X6 GRID
%DEFINE THE 2-D MAP ARRAY
X=0:16;
Y=0:16;
MAX_X=16;
MAX_Y=16;
figure('Color',[0.8 0.8 0.8]);
  plot(X,Y,'y');
  set(gca,'Color','y')
xlabel('Distance covered along x-direcction')
ylabel('Distance covered along y-direcction')
set(gca,'XTick',[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],'YTick',[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]);
axis([1 MAX_X+1 1 MAX_Y+1])
grid on;
hold on;
n=0;%Number of Obstacles
MAX_X=16;
MAX_Y=16;
MAX_VAL=6;
Q=2*(ones(MAX_X,MAX_Y)); % Obstacle=-1,Target = 0,Robot=1,Space=2
j=0;
x_val = 1;
y_val = 1;
% BEGIN Interactive Obstacle, Target, Start Location selection
pause(1);

h=msgbox('Please Select the Target using the Left Mouse button');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('Please Select the Target using the Left Mouse button','Color','black');
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
end
xval=floor(xval);
yval=floor(yval);
xTarget=xval;%X Coordinate of the Target
yTarget=yval;%Y Coordinate of the Target

Q(xval,yval)=0;%Initialize MAP with location of the target
plot(xval+.5,yval+.5,'gd');
text(xval+1,yval+.5,'Target')

pause(2);
h=msgbox('Select Obstacles using the Left Mouse button,to select the last obstacle use the Right button');
  xlabel('Select Obstacles using the Left Mouse button,to select the last obstacle use the Right button','Color','blue');
uiwait(h,10);
if ishandle(h) == 1
    delete(h);
end
while but == 1
    [xval,yval,but] = ginput(1);
    xval=floor(xval);
    yval=floor(yval);
    Q(xval,yval)=-1;%Put on the closed list as well
    plot(xval+.5,yval+.5,'m s','MarkerSize',10,'LineWidth',5);
 end%End of While loop
 
pause(1);

h=msgbox('Please Select the Vehicle initial position using the Left Mouse button');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('Please Select the Vehicle initial position ','Color','black');
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
    z1=xval;
    z2=yval;
    xval=floor(xval);
    yval=floor(yval);
end
xStart=xval;%Starting Position
yStart=yval;%Starting Position
Q(xval,yval)=1;
 plot(xval+.5,yval+.5,'bo');
%End of obstacle-Target pickup

q_value=[];
map1=[];
maxItr=input('Enter the maximum iterations required:');
alpha=0.5;
gamma=0.5;
Goal=36;
reward=1*(ones(MAX_X,MAX_Y));

for i=1:maxItr
    % Starting from any Random state    
    cs=randi([1 length(Q)],1,1);
    
    % Repeate until Goal state is reached
    while(1)
        % Possible Actions from current state        
        actions=find(reward(cs,:)>0);
        cs=36;
        % Next State due to possible actions
        ns=actions(randi([1 length(actions)]));
        % Possible Actions from Next State
        actions=find(reward(ns,:)>0);       
        % q value, for action is choosen randomly from all possible actions
%        randq=q(ns,actions(randi([1,length(actions)])));
        % Updation of Action-Value Function (SARSA)      
        % q(cs,ns)=q(cs,ns)+alpha*(reward(cs,ns)+gamma*randq -q(cs,ns));
        % Break, if Goal state is reached
        if(cs == Goal)
            break;
        end
        % Else Current-state is Next-State
        cs=ns;
    end  
end
%Put all obstacles on the Closed list
k=1;%Dummy counter
%tic
for i=1:MAX_X
    for j=1:MAX_Y
        if(Q(i,j) == -1)
            map1(k,1)=i; 
            map1(k,2)=j; 
             k=k+1;
        end
    end
end
map1_COUNT=size(map1,1);
%set the starting node as the first node
xNode=xval;
yNode=yval;
qvalue_COUNT=1;
path_cost=0;
goal_distance=distance(xNode,yNode,xTarget,yTarget);
q_value(qvalue_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);
q_value(qvalue_COUNT,1)=0;
map1_COUNT=map1_COUNT+1;
map1(map1_COUNT,1)=xNode;
map1(map1_COUNT,2)=yNode;
NoPath=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
%  plot(xNode+.5,yNode+.5,'go');
 exp_array=expand_array(xNode,yNode,path_cost,xTarget,yTarget,map1,MAX_X,MAX_Y);
 exp_count=size(exp_array,1);
 for i=1:exp_count
    flag=0;
    for j=1:qvalue_COUNT
        if(exp_array(i,1) == q_value(j,2) && exp_array(i,2) == q_value(j,3) )
            q_value(j,8)=min(q_value(j,8),exp_array(i,5)); %#ok<*SAGROW>
            if q_value(j,8)== exp_array(i,5)
                %UPDATE PARENTS,gn,hn
                q_value(j,4)=xNode;
                q_value(j,5)=yNode;
                q_value(j,6)=exp_array(i,3);
                q_value(j,7)=exp_array(i,4);
            end;%End of minimum fn check
            flag=1;
        end;%End of node check
%         if flag == 1
%             break;
    end;%End of j for
    if flag == 0
        qvalue_COUNT = qvalue_COUNT+1;
        q_value(qvalue_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
     end;%End of insert new element into the OPEN list
 end;%End of i for
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %END OF WHILE LOOP
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Find out the node with the smallest fn 
  index_min_node = min_fn(q_value,qvalue_COUNT,xTarget,yTarget);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   xNode=q_value(index_min_node,2);
   yNode=q_value(index_min_node,3);
   path_cost=q_value(index_min_node,6);%Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  map1_COUNT=map1_COUNT+1;
  map1(map1_COUNT,1)=xNode;
  map1(map1_COUNT,2)=yNode;
  q_value(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0;%Exits the loop!
  end;%End of index_min_node check
end;%End of While Loop
%Once algorithm has run The optimal path is generated by starting of at the
%last node(if it is the target node) and then identifying its parent node
%until it reaches the start node.This is the optimal path

i=size(map1,1);
Optimal_path=[xval yval];
xval=map1(i,1);
yval=map1(i,2);
i=1;
Optimal_path(i,1)=xval;
Optimal_path(i,2)=yval;
i=i+1;
%plot(Optimal_path(:,1)+.5,[xval yval],'k','LineWidth',4);
if ( (xval == xTarget) && (yval == yTarget))
    inode=0;
   %Traverse OPEN and determine the parent nodes
   parent_x=q_value(node_index(q_value,xval,yval),4);%node_index returns the index of the node
   parent_y=q_value(node_index(q_value,xval,yval),5);
   
   while( parent_x ~= xStart || parent_y ~= yStart)
           Optimal_path(i,1) = parent_x;
           Optimal_path(i,2) = parent_y;
           %Get the grandparents:-)
           inode=node_index(q_value,parent_x,parent_y);
           parent_x=q_value(inode,4);%node_index returns the index of the node
           parent_y=q_value(inode,5);
        %   plot(Optimal_path(:,1)+.5,Optimal_path(:,2)+.5,'k','LineWidth',4);
           i=i+1;
    end;
 j=size(Optimal_path,1);
 
 %Plot the Optimal Path!
% plot(Optimal_path(:,1)-.5,Optimal_path(:,2)-.5,'k','LineWidth',4);
 p=plot(Optimal_path(j,1)+.5,Optimal_path(j,2)+.5,'bo');
 disp(p);
 j=j-1;
 for i=j:-1:1
  pause(.25);
  set(p,'XData',Optimal_path(i,1)+.5,'YData',Optimal_path(i,2)+.5);
  %plot(Optimal_path(j,1)+.5,Optimal_path(j,2)+.5,'bo');
 drawnow ;
 end;
 disp(Optimal_path(j,1));
 plot(Optimal_path(:,1)+.5,Optimal_path(:,2)+.5,'k','LineWidth',2);
else
 pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
end
 z1=floor(z1);
 z2=floor(z2);
if  ((Optimal_path(j,2)>1)&&(Optimal_path(j,1)==1))
 x1=[(z1+.5),(Optimal_path(j,1)+.5)];%,(xval)];        
y1=[(z2+.5),(Optimal_path(j,2)-.5)];%,(yval)];
disp(Optimal_path(j,1));
disp(Optimal_path(j,2));
       plot(x1,y1,'k','LineWidth',2);
else if(Optimal_path(j,2)>1)
         x1=[(z1+.5),(Optimal_path(j,1)-.5)];%,(xval)];        
y1=[(z2+.5),(Optimal_path(j,2)-.5)];%,(yval)];
disp(Optimal_path(j,1));
disp(Optimal_path(j,2));
       plot(x1,y1,'k','LineWidth',2);
    else
    x1=[(z1+.5),(Optimal_path(j,1)+.5)];%,(xval)];       
    y1=[(z2+.5),(Optimal_path(j,2)+.5)];%,(yval)];
       plot(x1,y1,'k','LineWidth',2);
       disp(Optimal_path(j,1));
disp(Optimal_path(j,2));
    end
end
%toc