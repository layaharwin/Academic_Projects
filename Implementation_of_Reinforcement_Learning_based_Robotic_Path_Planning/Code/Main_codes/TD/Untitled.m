q1=1;q2=1;q3=1;q4=1;q5=1;q6=1;q7=1;q8=1;q9=1;q10=1;q11=1;q12=1;q13=1;q14=1;q15=1;q16=1;q17=1;q18=1;q19=1;q20=1;q21=1;
q22=1;q23=1;q24=1;q25=1;q26=1;q27=1;q28=1;q29=1;q30=1;q31=1;q32=1;
q33=1;
q34=1;
q35=1;
q36=1;

o=input('Enter number of obstacles:');
     x(1)=input('Enter the x coordinate of the first obstcle:');
     y(1)=input('Enter the y coordinate of the first obstcle:');
     x(2)=input('Enter the x coordinate of the second obstcle:');
     y(2)=input('Enter the y coordinate of the second obstcle:');
     x(3)=input('Enter the x coordinate of the third obstcle:');
     y(3)=input('Enter the y coordinate of the third obstcle:');
     x(4)=input('Enter the x coordinate of the fourth obstcle:');
     y(4)=input('Enter the y coordinate of the fourth obstcle:');
     x(5)=input('Enter the x coordinate of the fifth obstcle:');
     y(5)=input('Enter the y coordinate of the fifth obstcle:');
     x(6)=input('Enter the x coordinate of the sixth obstcle:');
     y(6)=input('Enter the y coordinate of the sixth obstcle:');
    
     % Obstacle plotting and Weight updation
for k=1:o
%      x(k)=input(['Enter the x coordinate of ' num2str(k) ' th obstacle']);
%      y(k)=input(['Enter the y coordinate of ' num2str(k) ' th obstacle']);
    
     plot(x(k),y(k),'m s','MarkerSize',25,'LineWidth',10);
     
     hold on
     x(k)=ceil(x(k));
     y(k)=ceil(y(k));

switch (x(k))          % Updating the Modified utility factor based on the obstacle position
    case (1)
        switch(y(k))
            case(1)
                 q1=-50;
            case(2)
                 q7=-50;
            case(3)
                 q13=-50;
            case(4)
                q19=-50;
            case(5)
                q25=-50;
            case(5)
                q31=-50;
        end
    case (2)
         switch(y(k))
            case(1)
                 q2=-50;
            case(2)
                 q8=-50;
            case(3)
                 q14=-50;
            case(4)
                 q20=-50;
             case(5)
                 q26=-50;   
             case(6)
                 q32=-50;
         end
    case(3)
         switch(y(k))
            case(1)
                 q3=-50;
            case(2)
                 q9=-50;
            case(3)
                 q15=-50;
            case(4)
                q21= -50;
             case(5)
                 q27=-50;
             case(6)
                 q33=-50;
         end
    case(4)
        switch(y(k))
            case(1)
                 q4=-50;
            case(2)
                 q10=-50;
            case(3)
                 q16=-50;
            case(4)
                q22=-50;
            case(5)
                q28=-50;
             case(6)
                q34=-50;
        end
    case(5)
        switch(y(k))
            case(1)
                 q5=-50;
            case(2)
                 q11=-50;
            case(3)
                 q17=-50 ;
            case(4)
                q23=-50;
            case(5)
                q29=-50;
             case(6)
                 q35=-50;
        end
    case(6)
        switch(y(k))
            case(1)
                 q6=-50;
            case(2)
                 q12=-50;
            case(3)
                 q18=-50;
            case(4)
                q24=-50;
            case(5)
                q30=-50;
             case(6)
                 q36=-50;
        end
end
end
q1=0;
q36=10;
q37=[q1 q2 q3 q4 q5 q6];
q38=[q7 q8 q9 q10 q11 q12];
q39=[q13 q14 q15 q16 q17 q18];
q40=[q19 q20 q21 q22 q23 q24];
q41=[q25 q26 q27 q28 q29 q30];
q42=[q31 q32 q33 q34 q35 q36];
q43=[0 0 0 0 0 0];
q44=[0 0 0 0 0 0];
maze=[q37;q38;q39;q40;q41;q42];

disp(maze);

n=6;
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
q=zeros(size(reward));
for i=1:Goal
    reward=[reward;reshape(q,1,Goal)];
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

% * Repeat until Convergence OR Maximum Iterations
% * cs => current state
% * ns => next state
disp(length(reward));
%
for i=1:10
    
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
disp(q);


move=0;
%start=input('enter the start point:');
stx=0;
sty = 0;
%0];%getcoordinate(start);
path=[start];
%Goal=input('enter the destination point');
dx=5;
dy=5;%] = [5 5]%getcoordinate(Goal);
text(stx,sty,'START','HorizontalAlignment','center')
text(dx,dy,'GOAL','HorizontalAlignment','center')
disp(q(cs,ns));



while(move~=Goal)
    [~,move]=max(q(start,:));
    
    % Deleting chances of getting stuck in small loops    
    if ismember(move,path)
        [~,x]=sort(q_(start,:),'descend');
        move=x(2); 
        if ismember(move,path)
            [~,x]=sort(q_(start,:),'descend');
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