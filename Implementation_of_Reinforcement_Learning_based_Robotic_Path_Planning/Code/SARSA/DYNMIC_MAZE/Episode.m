function [ total_reward,steps,Q,Model ] = Episode( maxsteps, Q,Model , alpha, gamma,epsilon,statelist,actionlist,grafic,maze,start,goal,p_steps )
% Episode do one episode of the mountain car with sarsa learning
% maxstepts: the maximum number of steps per episode
% Q: the current QTable
% alpha: the current learning rate
% gamma: the current discount factor
% epsilon: probablity of a random action
% statelist: the list of states
% actionlist: the list of actions

% Maze
% Programmed in Matlab 
% by:
%  Jose Antonio Martin H. <jamartinh@fdi.ucm.es>
% 
% 





x            = start;
steps        = 0;
total_reward = 0;


% convert the continous state variables to an index of the statelist
s   = DiscretizeState(x,statelist);
% selects an action using the epsilon greedy selection strategy
a   = e_greedy_selection(Q,s,epsilon);


for i=1:maxsteps    
        
    % convert the index of the action into an action value
    action = actionlist(a);    
    
    %do the selected action and get the next car state    
    xp  = DoAction( action , x, maze );    
    
    % observe the reward at state xp and the final state flag
    [r,f]   = GetReward(xp,goal);
    total_reward = total_reward + r;
    
    % convert the continous state variables in [xp] to an index of the statelist    
    sp  = DiscretizeState(xp,statelist);
    
    % select action prime
    ap = e_greedy_selection(Q,sp,epsilon);
    
    
    % Update the Qtable, that is,  learn from the experience
    Q = UpdateQLearning( s, a, r, sp, ap, Q , alpha, gamma );
    
    % Planning 
    Model = UpdateModel(s,a,r,sp,Model);
    Q     = RandomPlanning(Q, Model, p_steps, alpha, gamma);
    
    
    %update the current variables
    s = sp;
    a = ap;
    x = xp;
    
    
    %increment the step counter.
    steps=steps+1;
    
   
    % Plot of the mountain car problem
    if (grafic==true)
        Plot( x,a,steps,maze,start,goal,['PLANNING (N=' num2str(p_steps) ')']);
    end
    
    % if reachs the goal breaks the episode
    if (f==true)
        break
    end
    
end


