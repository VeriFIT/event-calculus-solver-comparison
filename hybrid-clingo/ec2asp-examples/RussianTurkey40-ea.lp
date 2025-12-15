#const maxstep=4.
#const maxtime=40.



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

in_happens(load,10).

in_happens(spin,20).

in_happens(shoot,30).

negated_prints.

% --> find 2 models: one with alive after shoot and one with no alive after shoot