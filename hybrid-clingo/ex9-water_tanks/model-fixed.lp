
% ----- domain model -----

ffluent(water_left).
ffluent(water_right).
dfluent(left_filling).
dfluent(right_filling).  % replaced left_draining

event(start(left)).
event(start(right)).
event(switch_left).
event(switch_right).

initiates(start(left), left_filling, T) :- time(T).
initiates(start(right), right_filling, T) :- time(T).
releases(start(LR), water_left, T) :- time(T), event(start(LR)).
releases(start(LR), water_right, T) :- time(T), event(start(LR)).

initiates(switch_left, left_filling, T) :- time(T).
terminates(switch_left, right_filling, T) :- time(T).

terminates(switch_right, left_filling, T) :- time(T).
initiates(switch_right, right_filling, T) :- time(T).

trajectory(left_filling, T1, water_left, (0, 1, 1, water_left, TotalFlow), T2) :-
    TotalFlow = 30 - 20, % in rate 30, out rate 20
    time(T1), time(T2).

trajectory(right_filling, T1, water_left, (0, 1, 1, water_left, -TotalFlow), T2) :-
    TotalFlow = 20, % out rate 20
    time(T1), time(T2).

trajectory(right_filling, T1, water_right, (0, 1, 1, water_right, TotalFlow), T2) :-
    TotalFlow = 30 - 20, % in rate 30, out rate 20
    time(T1), time(T2).

trajectory(left_filling, T1, water_right, (0, 1, 1, water_right, -TotalFlow), T2) :-
    TotalFlow = 20, % out rate 20
    time(T1), time(T2).

minDuration(1).
% trigger exactly at 50 if the trajectory took at least the minimum duration
happens(switch_left, T) :-
    holdsAt(right_filling, T),
    normal_atom(fholdsAt(water_left, T), eq, 50), % target level
    minDuration(MinDur),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    initiates(E, right_filling, T1),
    not stoppedIn(T1, right_filling, T),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), geq, MinDur),
    time(T1), time(T).
% trigger exactly after the minimum duration if the level is below 50
happens(switch_left, T) :-
    holdsAt(right_filling, T),
    normal_atom(fholdsAt(water_left, T), leq, 50), % target level
    minDuration(MinDur),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    initiates(E, right_filling, T1),
    not stoppedIn(T1, right_filling, T),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), eq, MinDur),
    time(T1), time(T).

% trigger exactly at 50 if the trajectory took at least the minimum duration
happens(switch_right, T) :-
    holdsAt(left_filling, T),
    normal_atom(fholdsAt(water_right, T), eq, 50), % target level
    minDuration(MinDur),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    initiates(E, left_filling, T1),
    not stoppedIn(T1, left_filling, T),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), geq, MinDur),
    time(T1), time(T).
% trigger exactly after the minimum duration if the level is below 50
happens(switch_right, T) :-
    holdsAt(left_filling, T),
    normal_atom(fholdsAt(water_right, T), leq, 50), % target level
    minDuration(MinDur),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    initiates(E, left_filling, T1),
    not stoppedIn(T1, left_filling, T),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), eq, MinDur),
    time(T1), time(T).

% TODO trigger_value must be more complex here, so manual
% cannot step over 50, if the duration is already over the minimum
comparison(fholdsAt(water_left,T), 50) :- time(T).
:-  normal_atom(fholdsAt(water_left, T), gt, 50),
    normal_atom(fholdsAt(water_left, T+1), lt, 50),
    T1 < T+1,
    happens(E, T1),
    initiates(E, right_filling, T1),
    not stoppedIn(T1, right_filling, T+1),
    time(T1), time(T),
    minDuration(MinDur),
    normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, MinDur),
    time(T), time(T+1).
comparison(fholdsAt(water_right,T), 50) :- time(T).
:-  normal_atom(fholdsAt(water_right, T), gt, 50),
    normal_atom(fholdsAt(water_right, T+1), lt, 50),
    T1 < T+1,
    happens(E, T1),
    initiates(E, left_filling, T1),
    not stoppedIn(T1, left_filling, T+1),
    time(T1), time(T),
    minDuration(MinDur),
    normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, MinDur),
    time(T), time(T+1).


% cannot step over the minimum duration time, if the level is already below 50
comparison(ftimeAtStep(T), -ftimeAtStep(T1), MinDur) :- minDuration(MinDur), T1 < T, time(T1), time(T).
:-  T1 < T+1,
    happens(E, T1),
    initiates(E, left_filling, T1),
    not stoppedIn(T1, left_filling, T+1),
    time(T1), time(T),
    minDuration(MinDur),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), lt, MinDur),
    normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, MinDur),
    time(T), time(T+1),
    normal_atom(fholdsAt(water_right, T+1), lt, 50).
:-  T1 < T+1,
    happens(E, T1),
    initiates(E, right_filling, T1),
    not stoppedIn(T1, right_filling, T+1),
    time(T1), time(T),
    minDuration(MinDur),
    normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), lt, MinDur),
    normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, MinDur),
    time(T), time(T+1),
    normal_atom(fholdsAt(water_left, T+1), lt, 50).


% ----- narrative & queries  -----

initiallyP(water_left, 100).
initiallyP(water_right, 100).
initiallyN(F) :- not initiallyP(F), dfluent(F).

in_happens(start(right),           10).

% happens(switch_left,25/2)
% happens(switch_left,145/8)
% happens(switch_left,161/8)
% happens(switch_left,177/8)
% happens(switch_right,65/4)
% happens(switch_right,153/8)
% happens(switch_right,169/8)
% happens(start(right),10)
