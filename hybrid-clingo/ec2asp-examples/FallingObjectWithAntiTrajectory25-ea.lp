#const maxstep=2.
#const maxtime=25.

% height(0..18).
% offset(1..18).

object(apple).
agent(nathan).


dfluent(falling(Object)) :- object(Object).
ffluent(height(Object)) :- object(Object).

event(drop(Agent,Object)) :- agent(Agent), object(Object).
event(hitGround(Object)) :- object(Object).



initiates(drop(Agent,Object),falling(Object),Time) :- agent(Agent), object(Object), step(Time).

terminates(hitGround(Object),falling(Object),Time) :- object(Object), step(Time).

happens(hitGround(Object),Time) :- holdsAt(falling(Object),Time), normal_atom((height(Object), Time), eq, 0).
trigger_value(height(Object), falling(Object), 0) :- object(Object).

in_happens(drop(nathan,apple),0).

% not needed, implicit
% :- holdsAt(height(Object,Height1),Time), holdsAt(height(Object,Height2),Time), Height1!=Height2.

trajectory(falling(Object),Time,height(Object), (0,0,1,height(Object),-1),Time2) :- object(Object), step(Time), step(Time2).

antiTrajectory(falling(Object),Time,height(Object), (0,0,1,height(Object),0),Time2) :- object(Object), step(Time), step(Time2).


:- holdsAt(falling(apple),0).

%holdsAt(height(apple,18),0).
in_fvalue(height(apple), 18, 0).

:- releasedAt(falling(Object),0).

releasedAt(height(Object),0) :- object(Object).

% --> conclude hit ground at time 18, and hight zero after
