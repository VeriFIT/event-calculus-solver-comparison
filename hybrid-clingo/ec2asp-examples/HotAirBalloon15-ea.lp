#const maxstep=2.
#const maxtime=15.

% height(0..6).
% offset(1..6).



balloon(balloon).
agent(nathan).


dfluent(heaterOn(Balloon)) :- balloon(Balloon).
ffluent(height(Balloon)) :- balloon(Balloon).

event(turnOnHeater(Agent,Balloon)) :- agent(Agent), balloon(Balloon).
event(turnOffHeater(Agent,Balloon)) :- agent(Agent), balloon(Balloon).



initiates(turnOnHeater(Agent,Balloon),heaterOn(Balloon),S) :- agent(Agent), balloon(Balloon), step(S).

terminates(turnOffHeater(Agent,Balloon),heaterOn(Balloon),S):- agent(Agent), balloon(Balloon), step(S).

in_happens(turnOnHeater(nathan,balloon),0).

in_happens(turnOffHeater(nathan,balloon),6).

% implicit
%:- holdsAt(height(Balloon,Height1),S), holdsAt(height(Balloon,Height2),S), Height1!=Height2.

trajectory(heaterOn(Balloon),S,height(Balloon), (0,0,1,height(Balloon),1), S2) :- balloon(Balloon), step(S), step(S2).

antiTrajectory(heaterOn(Balloon),S,height(Balloon), (0,0,1,height(Balloon),-1), S2) :- balloon(Balloon), step(S), step(S2).

%holdsAt(height(balloon,0),0).
in_fvalue(height(balloon), 0, 0).    % TODO fluent value time 

:- holdsAt(heaterOn(balloon),0).

releasedAt(height(Balloon),S) :- balloon(Balloon), step(S).

:- releasedAt(heaterOn(Balloon),0).

% --> conclude height 6 at time 6, and height -3 at time 15
