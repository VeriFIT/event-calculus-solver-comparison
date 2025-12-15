#const maxstep=2.
#const maxtime=20.

% height(0..8).
% offset(1..8).



balloon(balloon).
agent(nathan).


dfluent(heaterOn(Balloon)) :- balloon(Balloon).
ffluent(height(Balloon)) :- balloon(Balloon).

event(turnOnHeater(Agent,Balloon)) :- agent(Agent), balloon(Balloon).
event(turnOffHeater(Agent,Balloon)) :- agent(Agent), balloon(Balloon).



initiates(turnOnHeater(Agent,Balloon),heaterOn(Balloon),Time) :- agent(Agent), balloon(Balloon), step(Time).

terminates(turnOffHeater(Agent,Balloon),heaterOn(Balloon),Time):- agent(Agent), balloon(Balloon), step(Time).

in_happens(turnOnHeater(nathan,balloon),0).

in_happens(turnOffHeater(nathan,balloon),8).

% implicit
%:- holdsAt(height(Balloon,Height1),Time), holdsAt(height(Balloon,Height2),Time), Height1!=Height2.

trajectory(heaterOn(Balloon),Time,height(Balloon), (0,0,1,height(Balloon),1), Time2) :- balloon(Balloon), step(Time), step(Time2).

antiTrajectory(heaterOn(Balloon),Time,height(Balloon), (0,0,1,height(Balloon),-1), Time2) :- balloon(Balloon), step(Time), step(Time2).

%holdsAt(height(balloon,0),0).
in_fvalue(height(balloon), 0, 0).    % TODO fluent value time 

:- holdsAt(heaterOn(balloon),0).

releasedAt(height(Balloon),Time) :- balloon(Balloon), step(Time).

:- releasedAt(heaterOn(Balloon),0).

% --> conclude height 8 at time 8, and height -4 at time 20
