#const maxstep=2. % TODO one event happens at time zero
#const maxtime=40.

#const spillheight=25.
% offset(1..25). % TODO this was the duration of the trajectory



dfluent(filling).
ffluent(height).
dfluent(spilling).

event(tapOn).
event(tapOff).
event(overflow).



initiates(tapOn,filling,S) :- step(S).

terminates(tapOff,filling,S) :- step(S).

releases(tapOn,height,S) :- step(S).

initiates(tapOff,height,(0,0,1,height),S) :- step(S).

terminates(overflow,filling,S) :- step(S).

initiates(overflow,height,(0,0,1,height),S) :- step(S).

initiates(overflow,spilling,S) :- step(S).

trajectory(filling,S,height,(0,0,1,height,1), S2) :- step(S), step(S2).

% :- holdsAt(height(Height1),S), holdsAt(height(Height2),S), Height1!=Height2. % TODO not needed

happens(overflow,S) :- normal_atom((height,S), eq, spillheight), holdsAt(filling,S), step(S).
trigger_value(height, filling, spillheight).

in_fvalue(height, 0, 0).    % TODO fluent value time 

:- holdsAt(filling,0).

:- holdsAt(spilling,0).

in_happens(tapOn,0).

:- releasedAt(filling,0).

:- releasedAt(height,0).

:- releasedAt(spilling,0).

% --> conclude happens overflow at time "spillheight"