#const maxstep=2.   % TODO can give more or less steps since events are abduced
#const maxtime=2.



dfluent(carParked).

event(park).
event(steal).



initiates(park,carParked,S) :- step(S).

terminates(steal,carParked,S) :- step(S).



:- releasedAt(carParked,0).

:- holdsAt(carParked,0).

in_happens(park,0).

in_not_holdsAt(carParked, 2).

0 {happens(E, T)} 1 :- event(E), step(T), T<maxstep.

negated_prints.

% --> abduce happens steal after park (time between 0 and 2), i.e., in step 1 (initial is step 0, end is step 2)
% TODO the example gives no time information for step 1 --> solution says time(1)=2-e (happened "some" short time before time 2)