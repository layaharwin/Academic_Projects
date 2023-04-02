% PROJECT TOPIC: IMPLEMENTATION OF REINFORCEMENT LEARNING BASED ROBOTIC
% PATH PLANNING
% WORK DONE FOR THIRD REVIEW

     
% MAZE Solver using SARSA Learning
% Initailization

clear all;clc;
load('maze8x8.mat');
maze8x8 = [0 1 -50 -50 -50 1 1 -50;
   -50 -50 1 1 -50 -50 -50 -50;
   -50 1 1 -50 1 1 1 1;
   -50 -50 -50 1 -50 -50 -50 1;
   1 -50 1 -50 -50 -50 -50 -50;
   1 1 -50 1 -50 1 1 -50;
   -50 -50 1 -50 1 -50 1 1;
   -50 1 -50 -50 1 1 -50 10];
matrixPlot(maze)
% Plotting Environment of the maze, dimensions of maze : 8x8 (i.e, n = 8)
% * Starting Position is (1,1)
% * Goal is to reach (8,8)
%
n=length(maze);
%PLOTTING THE FIRST IMAGE ACCORDING TO THE MAZE MATRIX WHICH IS ALREADY
%ALLOCATED
figure
imagesc(maze)
colormap(summer(5))

for i=1:n
    for j=1:n
        if maze(i,j)==min(maze)
            text(j,i,'-X-','HorizontalAlignment','center')
        end
    end
end
% text(1,1,'START','HorizontalAlignment','center')
% text(n,n,'GOAL','HorizontalAlignment','center')

axis off

Goal=n*n;
fprintf('Goal State is: %d',Goal)
% Creating Reward Matrix for the Maze 
% Possible actions are:
% 
% * Up     (i-n)
% * Down   (i+n)
% * Left   (i-1)
% * Right  (i+1)
% * Diagonally SE (i+n+1)
% * Diagonally SW (i+n-1)
% * Diagonally NE (i-n+1)
% * Diagonally NW (i-n-1)
% 
% Reward  is -Inf (~No reward) for any other actions. Thus any other action 
% other then above action will not occur.
%
reward=[];

for i=1:Goal
    reward=[reward;reshape(maze',1,Goal);];
end
for i=1:Goal
for j=1:Goal
    if j~=i-n && j~=i+n && j~=i-1 && j~=i+1 && j~=i+n+1 && j~=i+n-1 && j~=i-n+1 && j~=i-n-1
        reward(i,j)=-Inf;
    end
end
end

% SARSA algorithm
% * Initialize the Q-matrix.
% * Setting the goal state to be 'n*n'. 
% * Gamma=0.5 and alpha=0.5 (Selected after several runs)
% * Maximum number of iterations (for convergence)
%
q=zeros(size(reward));
gamma=0.5; alpha=0.5; maxItr=200;

% 
% * Repeat until Convergence OR Maximum Iterations
% * cs => current state
% * ns => next state
disp(length(reward));
%
for i=1:maxItr
    
    % Starting from any Random state    
    cs=randi([1 length(reward)],1,1);
    %disp('cs');
    %disp(cs);
    % Repeate until Goal state is reached
    while(1)

        % Possible Actions from current state        
        actions=find(reward(cs,:)>0);
        %disp('actions');
     %   disp(actions);
        % Next State due to possible actions
        ns=actions(randi([1 length(actions)]));
      %  disp('ns');
       % disp(ns);
        % Possible Actions from Next State
        actions=find(reward(ns,:)>0);
        %disp('actions');
        %disp(actions);            
        % q value, for action is choosen randomly from all possible actions
        randq=q(ns,actions(randi([1,length(actions)])));
       % disp('randq');
        %disp(randq);
        % Updation of Action-Value Function (SARSA)      
        q(cs,ns)=q(cs,ns)+alpha*(reward(cs,ns)+gamma*randq -q(cs,ns));
        %disp('q(cs,ns)');
        %disp(q(cs,ns));
        % Break, if Goal state is reached
        if(cs == Goal)
            break;
        end
    
        % Else Current-state is Next-State
        cs=ns;
    end  
end
%disp(q);
% Solving the maze i.e, finding a path (optimal) from START to GOAL
% * Starting from the first postion
%
%start=1;
move=0;
start=input('enter the start point:');
[stx sty] = getcoordinate(start);
path=[start];
Goal=input('enter the destination point');
[dx dy] = getcoordinate(Goal);
text(stx,sty,'START','HorizontalAlignment','center')
text(dx,dy,'GOAL','HorizontalAlignment','center')
disp(q(cs,ns));
% 
% * Iterating until Goal-State is reached
%

while(move~=Goal)
    [~,move]=max(q(start,:));
    
    % Deleting chances of getting stuck in small loops    
    if ismember(move,path)
        [~,x]=sort(q(start,:),'descend');
        move=x(2); 
        if ismember(move,path)
            [~,x]=sort(q(start,:),'descend');
            move=x(3);  
        end
    end
    
    % Appending next action/move to the path
    path=[path,move]
    start=move;
end
% Solution of maze i.e, Optimal Path between START to GOAL
%
fprintf('Final Path: %s',num2str(path))

pmat=zeros(n,n);

[q, r]=quorem(sym(path),sym(n));
q=double(q+1);r=double(r);
q(r==0)=n;r(r==0)=n;

for i=1:length(q)
    pmat(q(i),r(i))=50;
end  
% Final Plot of the maze
%
figure
imagesc(pmat)
colormap(white)

for i=1:n
    for j=1:n
        if maze(i,j)==min(maze)
            text(j,i,'X','HorizontalAlignment','center')
        end
        if pmat(i,j)==50
            text(j,i,'\bullet','Color','red','FontSize',28)
        end
    end
end
text(stx,sty,'START','HorizontalAlignment','center')
text(dx,dy,'GOAL','HorizontalAlignment','center')

hold on
imagesc(maze,'AlphaData',0.2)
colormap(winter)
hold off
axis off
%