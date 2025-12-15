#const maxstep=2.
#const maxtime=40.



dfluent(itsBlack).
dfluent(itsWhite).
dfluent(onBlack).
dfluent(onWhite).

event(throw).



initiates(throw,onWhite,S) :- holdsAt(itsWhite,S).

initiates(throw,onBlack,S) :- holdsAt(itsBlack,S).

holdsAt(itsWhite,S)|holdsAt(itsBlack,S) :- step(S).

releasedAt(itsBlack,S) :- step(S).

releasedAt(itsWhite,S) :- step(S).

:- releasedAt(onBlack,0).

:- releasedAt(onWhite,0).

:- holdsAt(onWhite,0).

:- holdsAt(onBlack,0).

in_happens(throw,35).

holdsAt(itsWhite,0).

holdsAt(itsBlack,0).

in_holdsAt(itsWhite,40).

in_holdsAt(itsBlack,40).

% --> find 3 models, differ in state after time 1: onWhite or onBlack or both
