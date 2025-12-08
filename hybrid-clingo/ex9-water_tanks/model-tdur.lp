
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

trajectory(left_filling, T1, water_left, (0, 1, 1, water_left, TotalFlow), timeDiff(T1, T2)) :- T1 < T2,
    TotalFlow = 30 - 20, % in rate 30, out rate 20
    time(T1), time(T2).

trajectory(right_filling, T1, water_left, (0, 1, 1, water_left, -TotalFlow), timeDiff(T1, T2)) :- T1 < T2,
    TotalFlow = 20, % out rate 20
    time(T1), time(T2).

trajectory(right_filling, T1, water_right, (0, 1, 1, water_right, TotalFlow), timeDiff(T1, T2)) :- T1 < T2,
    TotalFlow = 30 - 20, % in rate 30, out rate 20
    time(T1), time(T2).

trajectory(left_filling, T1, water_right, (0, 1, 1, water_right, -TotalFlow), timeDiff(T1, T2)) :- T1 < T2,
    TotalFlow = 20, % out rate 20
    time(T1), time(T2).

happens(switch_left, T) :-
    holdsAt(right_filling, T),
    normal_atom(fholdsAt(water_left, T), leq, 50). % target level
%comparison(fholdsAt(water_left, T), 50) :- time(T).

happens(switch_right, T) :-
    holdsAt(left_filling, T),
    normal_atom(fholdsAt(water_right, T), leq, 50). % target level
%comparison(fholdsAt(water_right, T), 50) :- time(T).

% this is needed bc of the leq above
trigger_value(water_left, right_filling, 50).
trigger_value(water_right, left_filling, 50).

% TODO this is not needed in this model since there always will be an event at "eq 50" (zeno behavior)
%checkStep(T) :- time(T), holdsAt(right_filling, T), normal_atom(fholdsAt(water_left, T), eq, 50).
%checkStep(T) :- time(T), holdsAt(left_filling, T), normal_atom(fholdsAt(water_right, T), eq, 50).


% ----- narrative & queries  -----

initiallyP(water_left, 100).
initiallyP(water_right, 100).
initiallyN(F) :- not initiallyP(F), dfluent(F).

in_happens(start(right),           10).

% for maxstep 6 without laststep
% happens(switch_left,25/2)
% happens(switch_left,145/8)
% happens(switch_left,625/32)
% happens(switch_right,65/4)
% happens(switch_right,305/16)
% happens(start(right),10)