
% ----- domain model -----

event(turn_light_on).
event(turn_light_off).

dfluent(light_on).

initiates(turn_light_on,  light_on, T) :- time(T).
terminates(turn_light_off, light_on, T) :- time(T).


happens(turn_light_off, T) :- holdsAt(light_on, T), time(T).

happens(turn_light_on, T) :- not holdsAt(light_on, T), time(T),
    T > 1. % TODO to avoid triggering before the first event


% ----- narrative & queries  -----

in_happens(turn_light_on,      10).

% TODO clingo-lpx can automatically use 'e' (I assume 'epsilon') to represent an infinitely small time step
