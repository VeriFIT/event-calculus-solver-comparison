#const maxstep=2.   % TODO less because one event at zero, and in_holdsAt at maxtime
#const maxtime=2.



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

in_holdsAt(onRed,2). % TODO can remove this to show both models

:- holdsAt(hasTicket,0).

in_happens(buy,0).

in_happens(board,1).

% --> abduce that board must have been boardRed
