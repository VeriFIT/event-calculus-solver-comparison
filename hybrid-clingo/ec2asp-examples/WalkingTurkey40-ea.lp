#const maxstep=3.
#const maxtime=40.



dfluent(loaded).
dfluent(alive).
dfluent(walking).

event(load).
event(shoot).



initiates(load,loaded,S) :- step(S).

terminates(shoot,alive,S) :- holdsAt(loaded,S).

%terminates(shoot,walking,S) :- terminates(shoot,alive,S).
terminates(E,walking,S) :- terminates(E,alive,S).   % TODO this is even better

:- releasedAt(loaded,0).

:- releasedAt(alive,0).

:- releasedAt(walking,0).

holdsAt(alive,0).

holdsAt(loaded,0).

holdsAt(walking,0).

in_happens(shoot,25).

in_not_holdsAt(walking,37).

negated_prints.

% --> conclude not walking after time 25