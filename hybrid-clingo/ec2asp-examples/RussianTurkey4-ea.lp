#const maxstep=4.
#const maxtime=4.



dfluent(loaded).
dfluent(alive).

event(load).
event(shoot).
event(spin).



initiates(load,loaded,S) :- step(S).

terminates(shoot,alive,S) :- holdsAt(loaded,S).

releases(spin,loaded,S) :- step(S).

terminates(shoot,loaded,S) :- step(S).

:- releasedAt(loaded,0).

:- releasedAt(alive,0).

holdsAt(alive,0).

:- holdsAt(loaded,0).

in_happens(load,1).

in_happens(spin,2).

in_happens(shoot,3).

negated_prints.

% --> conclude 2 models: one with alive after shoot and one with no alive after shoot