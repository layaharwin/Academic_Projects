N=input('Enter the size of the matrix:');

x1=input('Enter the x coordinate of start point:');
x2=input('Enter the y coordinate of start point:');

start       = [x1 x2];

y1=input('Enter the x coordinate of destination point:');
y2=input('Enter the y coordinate of destination point:');

goal        = [y1 y2];
%[maze N M]  = CreateMaze();

nrows = 6;
ncols = 6;
N=6;
M=6;
maze = zeros(nrows,ncols);

%Add some obstacles as ones in the maze
% Sutton and Barto Dyna-Q example maze.
%%input obstacles here
maze(3,3) =1;
%maze(5,2)   =1;

%statelist   = BuildStateList(N,M);  % the list of states
x1  = 0:N-1;
x2  = 0:M-1;
statelist = setprod(x1,x2);
%actionlist  = BuildActionList(); % the list of actions
actionlist = [1 ; 2 ; 3 ; 4];
nstates     = size(statelist,1);
nactions    = size(actionlist,1);
%Generate initial Population
%Q           = BuildQTable(nstates,nactions ); % the Qtable  
Q = zeros(nstates,nactions);
%Model       = BuildModel(nstates,nactions ); % the Qtable  
Model = zeros(nstates,nactions,2);
% planning steps
p_steps     = 50;

maxsteps    = 2000;  % maximum number of steps per episode
alpha       = 0.1;   % learning rate
gamma       = 0.95;  % discount factor
epsilon     = 0.1;   % probability of a random action selection


grafica     = false; % indicates if display the graphical interface
grafica     = true;
xpoints=[];
ypoints=[];

maxepisodes=input('Enter the number of episodes required:');

for i=1:maxepisodes    
    
    
    [total_reward,steps,Q,Model ] =  Episode( maxsteps, Q, Model , alpha, gamma,epsilon,statelist,actionlist,grafica,maze,start,goal,p_steps ) ;  
    disp(steps);
    disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])
    
end

