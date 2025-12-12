#const maxstep=3.   % TODO event at zero
#const maxtime=3.



dfluent(loaded).
dfluent(alive).

event(load).
event(shoot).
event(sneeze).



initiates(load,loaded,S) :- step(S).

terminates(shoot,alive,S) :- holdsAt(loaded,S).

terminates(shoot,loaded,S) :- step(S).

:- releasedAt(loaded,0).

:- releasedAt(alive,0).

holdsAt(alive,0).

:- holdsAt(loaded,0).

in_happens(load,0).

in_happens(sneeze,1).

in_happens(shoot,2).

negated_prints.

% --> conclude not alive after 2