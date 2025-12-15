#const maxstep=4.
#const maxtime=40.



dfluent(hasTicket).
dfluent(onRed).
dfluent(onYellow).

event(buy).
event(board).
event(boardRed).
event(boardYellow).



happens(boardRed,S)|happens(boardYellow,S) :- happens(board,S).

initiates(buy,hasTicket,S) :- step(S).

initiates(boardRed,onRed,S) :- holdsAt(hasTicket,S).

initiates(boardYellow,onYellow,S) :- holdsAt(hasTicket,S).

:- holdsAt(onRed,S), holdsAt(onYellow,S).

:- holdsAt(onYellow,S), holdsAt(onRed,S).

holdsAt(hasTicket,S) :- holdsAt(onRed,S).

holdsAt(hasTicket,S) :- holdsAt(onYellow,S).

:- releasedAt(hasTicket,0).

:- releasedAt(onRed,0).

:- releasedAt(onYellow,0).

in_holdsAt(onRed,38).

:- holdsAt(hasTicket,0).

in_happens(buy,24).

in_happens(board,35).

% --> abduce that board must have been boardRed
