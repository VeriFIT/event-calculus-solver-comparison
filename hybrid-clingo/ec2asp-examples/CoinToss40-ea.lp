#const maxstep=4.
#const maxtime=40.



dfluent(itsHeads).
dfluent(heads).

event(toss).



initiates(toss,heads,S) :- holdsAt(itsHeads,S), step(S).

terminates(toss,heads,S) :- not holdsAt(itsHeads,S), step(S).

releasedAt(itsHeads,S) :- step(S).

:- releasedAt(heads,0). % TODO step 0 is the same as time 0

holdsAt(heads,0).   % TODO step 0 is the same as time 0

in_happens(toss,10).

in_happens(toss,20).

in_happens(toss,30).

holdsAt(itsHeads,0).    % TODO step 0 is the same as time 0

in_holdsAt(itsHeads, 40).

% --> find 8 models (all combinations of coin toss results for 3 tosses)