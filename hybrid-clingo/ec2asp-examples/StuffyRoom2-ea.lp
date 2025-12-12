#const maxstep=2. % TODO there is an event at 0
#const maxtime=40.



dfluent(blocked1).
dfluent(blocked2).
dfluent(stuffy).

event(close1).
event(close2).
event(start).



initiates(close1,blocked1,S) :- step(S).

initiates(close2,blocked2,S) :- step(S).

holdsAt(blocked2,S) :- holdsAt(stuffy,S).

holdsAt(blocked1,S) :- holdsAt(stuffy,S).

holdsAt(stuffy,S) :- holdsAt(blocked1,S), holdsAt(blocked2,S).

initiates(start,blocked1,S) :- step(S).

terminates(start,blocked2,S) :- step(S).

releasedAt(stuffy,S) :- step(S).

:- releasedAt(blocked1,0).

:- releasedAt(blocked2,0).

:- holdsAt(blocked1,0).

:- holdsAt(blocked2,0).

in_happens(start,0).

in_happens(close2,1).

% --> conclude stuffy after time 1