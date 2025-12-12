#const maxstep=2.
#const maxtime=40.



person(fred).

dfluent(happy(Person)) :- person(Person).
dfluent(hungry(Person)) :- person(Person).
dfluent(cold(Person)) :- person(Person).

event(feed(Person)) :- person(Person).
event(clothe(Person)) :- person(Person).



:- holdsAt(happy(Person),S), holdsAt(cold(Person),S).

:- holdsAt(happy(Person),S), holdsAt(hungry(Person),S).

holdsAt(happy(Person),S) :- not holdsAt(hungry(Person),S), not holdsAt(cold(Person),S), step(S), person(Person).

terminates(feed(Person),hungry(Person),S) :- step(S), person(Person).

terminates(clothe(Person),cold(Person),S) :- step(S), person(Person).

releasedAt(happy(Person),S) :- step(S), person(Person).

:- releasedAt(hungry(Person),0).

:- releasedAt(cold(Person),0).

holdsAt(hungry(fred),0).

:- holdsAt(cold(fred),0).

in_happens(feed(fred),25).

% --> conclude happy(fred) after 25