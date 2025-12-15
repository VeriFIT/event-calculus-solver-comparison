#const maxstep=1.
#const maxtime=1.



dfluent(light).
dfluent(switch1).
dfluent(switch2).
dfluent(switch3).
dfluent(relay).

event(lightOn).
event(close1).
event(open2).
event(closeRelay).



happens(lightOn,S) :- stopped(light,S), initiated(switch1,S), initiated(switch2,S).

happens(open2,S) :- started(switch2,S), initiated(relay,S).

happens(closeRelay,S) :- stopped(relay,S), initiated(switch1,S), initiated(switch3,S).

initiates(lightOn,light,S) :- step(S).

terminates(open2,switch2,S) :- step(S).

initiates(closeRelay,relay,S) :- step(S).

initiates(close1,switch1,S) :- step(S).

:- releasedAt(light,0).

:- releasedAt(switch1,0).

:- releasedAt(switch2,0).

:- releasedAt(switch3,0).

:- releasedAt(relay,0).

:- holdsAt(switch1,0).

holdsAt(switch2,0).

holdsAt(switch3,0).

:- holdsAt(relay,0).

:- holdsAt(light,0).

in_happens(close1,0).

negated_prints.

% --> conclude not light on after time 0 (light not on after closing switch1)