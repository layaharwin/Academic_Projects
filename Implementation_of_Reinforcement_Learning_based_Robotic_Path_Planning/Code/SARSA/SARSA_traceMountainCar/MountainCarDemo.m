function  MountainCarDemo( maxepisodes )
%MountainCarDemo, the main function of the demo
%maxepisodes: maximum number of episodes to run the demo


clc
clf
set(gco,'BackingStore','off')
maxsteps    = 1000;  % maximum number of steps per episode
statelist   = BuildStateList();  % the list of states
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,1);
Q           = BuildQTable( nstates,nactions );  % the QTable
trace       = BuildQTable( nstates,nactions );  % the elegibility trace

alpha       = 0.5;   % learning rate
gamma       = 1.0;   % discount factor
lambda      = 0.95;   % the decaying elegibiliy trace parameter
epsilon     = 0.01;  % probability of a random action selection
grafica     = false;%true; % indicates if display the graphical interface

xpoints=[];
ypoints=[];

for i=1:maxepisodes    
    trace(:,:)=0.0;
    [total_reward,steps,Q,trace ] = MountainCarEpisode( maxsteps, Q, trace , alpha, gamma, epsilon, lambda, statelist,actionlist,grafica );    
    
    disp(['Espisode: ',int2str(i),' steps: ',int2str(steps),' reward: ',num2str(total_reward),' epsilon: ',num2str(epsilon)])
    epsilon = epsilon * 0.99;
    
    xpoints(i)=i-1;
    ypoints(i)=steps;
    subplot(2,1,1);    
    plot(xpoints,ypoints)      
    title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])    
    drawnow
    
    if (i>500)
        grafica=true;
    end
end






