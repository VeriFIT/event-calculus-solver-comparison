
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

trajectory(left_filling, T1, water_left, (0, 1, 0, water_left, TotalFlow), T2) :-
    TotalFlow = 30 - 20, % in rate 30, out rate 20
    time(T1), time(T2).

trajectory(right_filling, T1, water_left, (0, 1, 0, water_left, -TotalFlow), T2) :-
    TotalFlow = 20, % out rate 20
    time(T1), time(T2).

trajectory(right_filling, T1, water_right, (0, 1, 0, water_right, TotalFlow), T2) :-
    TotalFlow = 30 - 20, % in rate 30, out rate 20
    time(T1), time(T2).

trajectory(left_filling, T1, water_right, (0, 1, 0, water_right, -TotalFlow), T2) :-
    TotalFlow = 20, % out rate 20
    time(T1), time(T2).

minDuration(1).
% trigger exactly at 50 if the trajectory took at least the minimum duration
happens(switch_left, T) :-
    holdsAt(right_filling, T),
    minDuration(MinDur),
    normal_atom(aux__rightFillDurAtStep(T1, T), geq, MinDur),
    %trajectoryAtStep(right_filling, T1, water_left, T), 
        T1 < T,
        initiates(E, right_filling, T1),
        happens(E, T1),
        trajectory(right_filling, T1, water_left, _, T),
        not stoppedIn(T1, right_filling, T),
        time(T),
    normal_atom(fholdsAt(water_left, T), eq, 50). % target level

% trigger exactly after the minimum duration if the level is below 50
happens(switch_left, T) :-
    holdsAt(right_filling, T),
    minDuration(MinDur),
    normal_atom(aux__rightFillDurAtStep(T1, T), eq, MinDur),
    %trajectoryAtStep(right_filling, T1, water_left, T), 
        T1 < T,
        initiates(E, right_filling, T1),
        happens(E, T1),
        trajectory(right_filling, T1, water_left, _, T),
        not stoppedIn(T1, right_filling, T),
        time(T),
    normal_atom(fholdsAt(water_left, T), leq, 50). % target level
%comparison(fholdsAt(water_left, T), 50) :- time(T).

&sum{ftimeAtStep(T2) - ftimeAtStep(T1)} = aux__rightFillDurAtStep(T1, T2) :-
    %trajectoryAtStep(right_filling, T1, water_left, T2), 
        T1 < T2,
        initiates(E, right_filling, T1),
        happens(E, T1),
        trajectory(right_filling, T1, water_left, _, T2),
        not stoppedIn(T1, right_filling, T2),
    time(T1), time(T2).
defined(aux__rightFillDurAtStep(T1, T2)) :-
    %trajectoryAtStep(right_filling, T1, water_left, T2), 
        T1 < T2,
        initiates(E, right_filling, T1),
        happens(E, T1),
        trajectory(right_filling, T1, water_left, _, T2),
        not stoppedIn(T1, right_filling, T2),
    time(T1), time(T2).
&sum{0} = aux__rightFillDurAtStep(T1, T2) :- not defined(aux__rightFillDurAtStep(T1, T2)),
    T1 < T2, time(T1), time(T2).

% trigger exactly at 50 if the trajectory took at least the minimum duration
happens(switch_right, T) :-
    holdsAt(left_filling, T),
    minDuration(MinDur),
    normal_atom(aux__leftFillDurAtStep(T1, T), geq, MinDur),
    %trajectoryAtStep(left_filling, T1, water_right, T),
        T1 < T,
        initiates(E, left_filling, T1),
        happens(E, T1),
        trajectory(left_filling, T1, water_right, _, T),
        not stoppedIn(T1, left_filling, T),
        time(T),
    normal_atom(fholdsAt(water_right, T), eq, 50). % target level
% trigger exactly after the minimum duration if the level is below 50
happens(switch_right, T) :-
    holdsAt(left_filling, T),
    minDuration(MinDur),
    normal_atom(aux__leftFillDurAtStep(T1, T), eq, MinDur),
    %trajectoryAtStep(left_filling, T1, water_right, T),
        T1 < T,
        initiates(E, left_filling, T1),
        happens(E, T1),
        trajectory(left_filling, T1, water_right, _, T),
        not stoppedIn(T1, left_filling, T),
        time(T),
    normal_atom(fholdsAt(water_right, T), leq, 50). % target level
%comparison(fholdsAt(water_right, T), 50) :- time(T).

&sum{ftimeAtStep(T2) - ftimeAtStep(T1)} = aux__leftFillDurAtStep(T1, T2) :-
    %trajectoryAtStep(left_filling, T1, water_right, T2),
        T1 < T2,
        initiates(E, left_filling, T1),
        happens(E, T1),
        trajectory(left_filling, T1, water_right, _, T2),
        not stoppedIn(T1, left_filling, T2),
    time(T1), time(T2).
defined(aux__leftFillDurAtStep(T1, T2)) :-
    %trajectoryAtStep(left_filling, T1, water_right, T2),
        T1 < T2,
        initiates(E, left_filling, T1),
        happens(E, T1),
        trajectory(left_filling, T1, water_right, _, T2),
        not stoppedIn(T1, left_filling, T2),
    time(T1), time(T2).
&sum{0} = aux__leftFillDurAtStep(T1, T2) :- not defined(aux__leftFillDurAtStep(T1, T2)),
    T1 < T2, time(T1), time(T2).


% this is needed bc of the leq above
trigger_value(water_left, right_filling, 50).
trigger_value(water_right, left_filling, 50).

% TODO this needs to be discussed -- no all steps with water level 50 will have an event, therefore, make all of them checkSteps
checkStep(T) :- time(T), holdsAt(right_filling, T), normal_atom(fholdsAt(water_left, T), eq, 50).
checkStep(T) :- time(T), holdsAt(left_filling, T), normal_atom(fholdsAt(water_right, T), eq, 50).


% trigger_value(aux__rightFillDurAtStep(T), right_filling, MinDur) :- minDuration(MinDur), time(T).
% trigger_value(aux__leftFillDurAtStep(T), left_filling, MinDur) :- minDuration(MinDur), time(T).
comparison(aux__leftFillDurAtStep(T1, T2), MinDur) :- minDuration(MinDur), time(T1), T1 < T2, time(T2).
    %comparison(aux__leftFillDurAtStep(T2), MinDur) :- minDuration(MinDur), trajectoryAtStep(left_filling, T1, water_right, T2), time(T1), time(T2).
comparison(aux__rightFillDurAtStep(T1, T2), MinDur) :- minDuration(MinDur), time(T1), T1 < T2, time(T2).
    %comparison(aux__rightFillDurAtStep(T2), MinDur) :- minDuration(MinDur), trajectoryAtStep(right_filling, T1, water_left, T2), time(T1), time(T2).

:- holdsAt(left_filling, T+1), normal_atom(aux__leftFillDurAtStep(T1, T), lt, MinDur), normal_atom(aux__leftFillDurAtStep(T1, T+1), gt, MinDur), minDuration(MinDur), time(T1), T1 < T, time(T), time(T+1).
:- holdsAt(left_filling, T+1), normal_atom(aux__leftFillDurAtStep(T1, T), gt, MinDur), normal_atom(aux__leftFillDurAtStep(T1, T+1), lt, MinDur), minDuration(MinDur), time(T1), T1 < T, time(T), time(T+1).
 
:- holdsAt(right_filling, T+1), normal_atom(aux__rightFillDurAtStep(T1,T), lt, MinDur), normal_atom(aux__rightFillDurAtStep(T1, T+1), gt, MinDur), minDuration(MinDur), time(T1), T1 < T, time(T), time(T+1).
:- holdsAt(right_filling, T+1), normal_atom(aux__rightFillDurAtStep(T1,T), gt, MinDur), normal_atom(aux__rightFillDurAtStep(T1, T+1), lt, MinDur), minDuration(MinDur), time(T1), T1 < T, time(T), time(T+1).

% TODO this needs to be discussed -- no all steps with duration Mindur will have an event, therefore, make all of them checkSteps
checkStep(T) :- time(T), holdsAt(right_filling, T), normal_atom(aux__rightFillDurAtStep(T1, T), eq, MinDur), normal_atom(fholdsAt(water_left, T), leq, 50), time(T1), T1 < T, minDuration(MinDur).
checkStep(T) :- time(T), holdsAt(left_filling, T), normal_atom(aux__leftFillDurAtStep(T1, T), eq, MinDur), normal_atom(fholdsAt(water_right, T), leq, 50), time(T1), T1 < T, minDuration(MinDur).

% ----- narrative & queries  -----

initiallyP(water_left, 100).
initiallyP(water_right, 100).
initiallyN(F) :- not initiallyP(F), not initiallyP(F, _), fluent(F).

in_happens(start(right),           10).

% happens(switch_left,25/2)
% happens(switch_left,145/8)
% happens(switch_left,161/8)
% happens(switch_left,177/8)
% happens(switch_right,65/4)
% happens(switch_right,153/8)
% happens(switch_right,169/8)
% happens(start(right),10)


% TODO probably fixed this by changing aux_ predicates to have T1 and T2 (not just T2), and by adding constraints that T1 < T2
