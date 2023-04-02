function [Q, trace] = UpdateSARSA_e( s, a, r, sp, ap, Q, trace, alpha, gamma, lambda )
% UpdateQ update de Qtable and return it using SARSA
% s1: previous state before taking action (a)
% s2: current state after action (a)
% r: reward received from the environment after taking action (a) in state
%                                             s1 and reaching the state s2
% a:  the last executed action
% Q: the current Qtable
% alpha: learning rate
% gamma: discount factor
% lambda: eligibility trace decay factor
% trace : eligibility trace vector


delta  =  ( r + gamma * Q(sp,ap) ) - Q(s,a);
%trace(s,:) = 0.0;  %optional trace reset
trace(s,a) = 1.0;

Q = Q + alpha * delta * trace;

trace = gamma * lambda * trace;
