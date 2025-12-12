#const maxstep=3.   % TODO 2 sets of events that happen at the same time 
#const maxtime=40.



dfluent(forwards).
dfluent(backwards).
dfluent(spinning).

event(push).
event(pull).



initiates(push,forwards,S) :- not happens(pull,S), step(S).

terminates(push,backwards,S) :- not happens(pull,S), step(S).

initiates(pull,backwards,S) :- not happens(push,S), step(S).

terminates(pull,forwards,S) :- not happens(push,S), step(S).

initiates(pull,spinning,S) :- happens(push,S).

terminates(pull,forwards,S) :- happens(push,S).

terminates(pull,backwards,S) :- happens(push,S).

terminates(push,spinning,S) :- not happens(pull,S), step(S).

terminates(pull,spinning,S) :- not happens(push,S), step(S).

:- releasedAt(forwards,0).

:- releasedAt(backwards,0).

:- releasedAt(spinning,0).

:- holdsAt(forwards,0).

:- holdsAt(backwards,0).

:- holdsAt(spinning,0).

in_happens(push,15).

in_happens(pull,15).

in_happens(pull,35).

in_happens(push,35).

% --> conclude spinning after 15 and still spinning after 35