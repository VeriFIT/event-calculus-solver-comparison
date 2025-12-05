
% ----- domain model -----

event(turn_light_on).
event(turn_light_off).

dfluent(light_on).

initiates(turn_light_on,  light_on, T) :- time(T).
terminates(turn_light_off, light_on, T) :- time(T).

% time epsilon to trigger on/off(A)
epsilon("1.1").

happens(turn_light_off, T) :- holdsAt(light_on, T),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    initiates(E, light_on, T1),
    not stoppedIn(T1, light_on, T),
    epsilon(EPS),
    % &sum{ ftimeAtStep(T1) - EPS } = ftimeAtStep(T),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), eq, EPS),
        %normal_atom(ftimeAtStep(T1), EPS, eq, ftimeAtStep(T)),
    time(T).
comparison(ftimeAtStep(T), -ftimeAtStep(T1), EPS) :- epsilon(EPS), T1 < T, time(T1), time(T).
    %comparison(ftimeAtStep(T1), EPS, ftimeAtStep(T)) :- epsilon(EPS), T1 < T, time(T1), time(T).

happens(turn_light_on, T) :- not holdsAt(light_on, T), time(T),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    terminates(E, light_on, T1),
    not startedIn(T1, light_on, T),
    epsilon(EPS),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), eq, EPS),
        %normal_atom(ftimeAtStep(T1), EPS, eq, ftimeAtStep(T)),
    T > 1, time(T).

% TODO complicated trigger_value
% cannot step over T1 + epsilon
:-  % establish T1 (cause 1)
    happens(E, T1),
    initiates(E, light_on, T1),
    not stoppedIn(T1, light_on, T+1),
    % cannot step over it
    T > T1,
    epsilon(EPS),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), lt, EPS),
    normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, EPS),
    % if the trigger condition holds
    holdsAt(light_on, T).
:-  % establish T1 (cause 2)
    happens(E, T1),
    terminates(E, light_on, T1),
    not startedIn(T1, light_on, T+1),
    % cannot step over it
    T > T1,
    epsilon(EPS),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), lt, EPS),
    normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, EPS),
    % if the trigger condition holds
    not holdsAt(light_on, T).

% TODO need a special case for T = T1 + 1 because &sum{time(T) - time(T)} < EPS is unsat
:-  % establish T1 (cause 1)
    happens(E, T1),
    initiates(E, light_on, T1),
    % cannot step over it
    T = T1,
    epsilon(EPS),
    normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, EPS),
    % if the trigger condition holds
    holdsAt(light_on, T+1).
:-  % establish T1 (cause 2)
    happens(E, T1),
    terminates(E, light_on, T1),
    % cannot step over it
    T = T1,
    epsilon(EPS),
    normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, EPS),
    % if the trigger condition holds
    not holdsAt(light_on, T+1).


% ----- narrative & queries  -----
initiallyN(light_on).

in_happens(turn_light_on,      10).
