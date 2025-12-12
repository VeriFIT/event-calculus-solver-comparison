#const maxstep=4.
#const maxtime=40.



dfluent(loaded).
dfluent(alive).
dfluent(dead).

event(load).
event(shoot).
event(sneeze).



initiates(load,loaded,S) :- step(S).

terminates(shoot,alive,S) :- holdsAt(loaded,S), step(S).

terminates(shoot,loaded,S) :- step(S).

:- holdsAt(dead,S), holdsAt(alive,S).

holdsAt(dead,S) :- not holdsAt(alive,S), step(S).

releasedAt(dead,S) :- step(S).

:- releasedAt(loaded,0).

:- releasedAt(alive,0).

holdsAt(alive,0).

:- holdsAt(loaded,0).

in_happens(load,10).

in_happens(sneeze,20).

in_happens(shoot,35).

negated_prints.

% --> conclude dead after time 35, and alive before that 