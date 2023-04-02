function [ total_reward,steps,Q, trace ] = MountainCarEpisode( maxsteps, Q, trace, alpha, gamma, epsilon,lambda,statelist,actionlist,grafic )
%MountainCarEpisode do one episode of the mountain car with sarsa learning
% maxstepts: the maximum number of steps per episode
% Q: the current QTable
% alpha: the current learning rate
% gamma: the current discount factor
% epsilon: probablity of a random action
% statelist: the list of states
% actionlist: the list of actions

initial_position = -0.5;
initial_speed    =  0.0;

x=[initial_position,initial_speed];
steps = 0;
total_reward = 0;

s   = DiscretizeState(x,statelist);
a   = e_greedy_selection(Q,s,epsilon);


for i=1:maxsteps
        
    % convert the index of the action into an action value
    action = actionlist(a);    
    
    %do the selected action and get the next car state    
    xp  = MountainCarDoAction( action , x );
        
    % observe the reward at state xp and the final state flag
    [r,f]   = MountainCarGetReward(xp);
    total_reward = total_reward + r;
    
    % convert the continous state variables in [xp] to an index of the statelist    
    sp  = DiscretizeState(xp,statelist);
    
    % select action prime
    ap = e_greedy_selection(Q,sp,epsilon);
    
    
    % Update the Qtable, that is,  learn from the experience
    [Q, trace] = UpdateSARSA_e( s, a, r, sp, ap, Q, trace, alpha, gamma, lambda );
    
    
    
    %update the current variables
    s = sp;
    a = ap;
    x = xp;
    
    
    %increment the step counter.
    steps=steps+1;
    
   
    % Plot of the mountain car problem
    if (grafic==true)        
       MountainCarPlot(x,action,steps);    
    end
    
    % if the car reachs the goal breaks the episode
    if (f==true)
        break
    end
    
end


