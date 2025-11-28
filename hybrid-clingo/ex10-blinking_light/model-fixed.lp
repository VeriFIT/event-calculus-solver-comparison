
% ----- domain model -----

event(turn_light_on).
event(turn_light_off).

dfluent(light_on).

initiates(turn_light_on,  light_on, T) :- time(T).
terminates(turn_light_off, light_on, T) :- time(T).

% time epsilon to trigger on/off(A)
epsilon("1.1").

happens(turn_light_off, T) :- holdsAt(light_on, T),
    T1 < T,
    happens(E, T1),
    initiates(E, light_on, T1),
    not stoppedIn(T1, light_on, T),
    epsilon(EPS),
    normal_atom(ftimeAtStep(T1), EPS, eq, ftimeAtStep(T)),
    time(T).
comparison(ftimeAtStep(T1), EPS, ftimeAtStep(T)) :- epsilon(EPS), T1 < T, time(T1), time(T).

happens(turn_light_on, T) :- not holdsAt(light_on, T), time(T),
    T1 < T,
    happens(E, T1),
    terminates(E, light_on, T1),
    not startedIn(T1, light_on, T),
    epsilon(EPS),
    normal_atom(ftimeAtStep(T1), EPS, eq, ftimeAtStep(T)),
    T > 1, time(T).

% ----- narrative & queries  -----
initiallyN(light_on).

in_happens(turn_light_on,      10).
