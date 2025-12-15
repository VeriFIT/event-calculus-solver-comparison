#const maxstep=3.
#const maxtime=25.

% height(0..18).
% offset(1..18).

object(apple).
agent(nathan).


dfluent(falling(Object)) :- object(Object).
ffluent(height(Object)) :- object(Object).

event(drop(Agent,Object)) :- agent(Agent), object(Object).
event(hitGround(Object)) :- object(Object).



initiates(drop(Agent,Object),falling(Object),S) :- agent(Agent), object(Object), step(S).

releases(drop(Agent,Object),height(Object),S) :- agent(Agent), object(Object), step(S).

terminates(hitGround(Object),falling(Object),S) :- object(Object), step(S).

initiates(hitGround(Object),height(Object), (0,0,1,height(Object)),S) :- object(Object), step(S).

happens(hitGround(Object),S) :- holdsAt(falling(Object),S), normal_atom((height(Object), S), eq, 0).
trigger_value(height(Object), falling(Object), 0) :- object(Object).

in_happens(drop(nathan,apple),18).

% not needed, implicit
% :- holdsAt(height(Object,Height1),S), holdsAt(height(Object,Height2),S), Height1!=Height2.

trajectory(falling(Object),S,height(Object), (0,0,1,height(Object),-1),S2) :- object(Object), step(S), step(S2).

:- holdsAt(falling(apple),0).

%holdsAt(height(apple,3),18).
in_fvalue(height(apple), 3, 18).

:- releasedAt(falling(Object),0).

:- releasedAt(height(Object),0).

% --> conclude hit ground at time 21
