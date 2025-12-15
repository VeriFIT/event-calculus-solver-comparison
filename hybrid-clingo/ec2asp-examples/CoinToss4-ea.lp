#const maxstep=4.
#const maxtime=4.



dfluent(itsHeads).
dfluent(heads).

event(toss).



initiates(toss,heads,S) :- holdsAt(itsHeads,S), step(S).

terminates(toss,heads,S) :- not holdsAt(itsHeads,S), step(S).

releasedAt(itsHeads,S) :- step(S).

:- releasedAt(heads,0). % TODO step 0 is the same as time 0

holdsAt(heads,0).   % TODO step 0 is the same as time 0

in_happens(toss,1).

in_happens(toss,2).

in_happens(toss,3).

holdsAt(itsHeads,0).    % TODO step 0 is the same as time 0    

in_holdsAt(itsHeads, 4).

% --> find 8 models (all combinations of coin toss results for 3 tosses)