
% ----- domain model -----

event(turn_light_on).
event(turn_light_off).

dfluent(light_on).

initiates(turn_light_on,  light_on, T) :- time(T).
terminates(turn_light_off, light_on, T) :- time(T).


happens(turn_light_off, T) :- holdsAt(light_on, T), time(T).

happens(turn_light_on, T) :- not holdsAt(light_on, T), time(T),
    T > 1. % TODO to avoid triggering before the first event


% time epsilon to trigger on/off(A)
% TODO what if some other event happened in between T and T+1? --- probably need to ensure that epsilon is "small enough"?
epsilon("1.1"). % valid with clingo-lpx
&sum{ ftimeAtStep(T+1); -ftimeAtStep(T) } = E :- epsilon(E),
    happens(turn_light_on, T+1),
    time(T), time(T+1), 
    T > 0.
&sum{ ftimeAtStep(T+1); -ftimeAtStep(T) } = E :- epsilon(E),
    happens(turn_light_off, T+1),
    time(T), time(T+1), 
    T > 0.


% ----- narrative & queries  -----

in_happens(turn_light_on,      10).
