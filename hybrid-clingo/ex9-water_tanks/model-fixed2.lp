
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
    % TODO need to reference T1 as the time of start of the trajectory
    %trajectoryAtStep(right_filling, T1, water_left, T), 
        T1 < T,
        initiates(E, right_filling, T1),
        happens(E, T1),
        trajectory(right_filling, T1, water_left, _, T),
        not stoppedIn(T1, right_filling, T),
        time(T),
    happens(aux__endMinDurRightFilling(T1), T2), T1 < T2, T2 <= T,
    normal_atom(fholdsAt(water_left, T), eq, 50). % target level

% trigger exactly after the minimum duration if the level is below 50
happens(switch_left, T) :-
    holdsAt(right_filling, T),
    % TODO need to reference T1 as the time of start of the trajectory
    %trajectoryAtStep(right_filling, T1, water_left, T),
        T1 < T,
        initiates(E, right_filling, T1),
        happens(E, T1),
        trajectory(right_filling, T1, water_left, _, T),
        not stoppedIn(T1, right_filling, T),
        time(T),
    happens(aux__endMinDurRightFilling(T1), T),
    normal_atom(fholdsAt(water_left, T), lt, 50). % target level
%comparison(fholdsAt(water_left, T), 50) :- time(T).

% trigger exactly at 50 if the trajectory took at least the minimum duration
happens(switch_right, T) :-
    holdsAt(left_filling, T),
    % TODO need to reference T1 as the time of start of the trajectory
    %trajectoryAtStep(left_filling, T1, water_right, T),
        T1 < T,
        initiates(E, left_filling, T1),
        happens(E, T1),
        trajectory(left_filling, T1, water_right, _, T),
        not stoppedIn(T1, left_filling, T),
        time(T),
    happens(aux__endMinDurLeftFilling(T1), T2), T1 < T2, T2 <= T,
    normal_atom(fholdsAt(water_right, T), eq, 50). % target level
% trigger exactly after the minimum duration if the level is below 50
happens(switch_right, T) :-
    holdsAt(left_filling, T),
    % TODO need to reference T1 as the time of start of the trajectory
    %trajectoryAtStep(left_filling, T1, water_right, T),
        T1 < T,
        initiates(E, left_filling, T1),
        happens(E, T1),
        trajectory(left_filling, T1, water_right, _, T),
        not stoppedIn(T1, left_filling, T),
        time(T),
    happens(aux__endMinDurLeftFilling(T1), T),
    normal_atom(fholdsAt(water_right, T), lt, 50). % target level
%comparison(fholdsAt(water_right, T), 50) :- time(T).

% this is needed bc of the leq above
trigger_value(water_left, right_filling, 50).
trigger_value(water_right, left_filling, 50).

% TODO this needs to be discussed -- no all steps with water level 50 will have an event, therefore, make all of them checkSteps
checkStep(T) :- time(T), holdsAt(right_filling, T), normal_atom(fholdsAt(water_left, T), eq, 50).
checkStep(T) :- time(T), holdsAt(left_filling, T), normal_atom(fholdsAt(water_right, T), eq, 50).

% TODO this needs to be discussed -- a way to track minimal duration of a trajectory
% TODO this works but requires steps to be incremented by 2 (model at N, no model at N+1, model at N+2)
% trying to trigger an event MinDur time after switch_left/right happens
{happens(aux__endMinDurRightFilling(T1), T2) : time(T2), T2 > T1} = 1 :- happens(switch_right, T1), T1 < maxstep.
{happens(aux__endMinDurRightFilling(T1), T2) : time(T2), T2 > T1} = 1 :- happens(start(right), T1), T1 < maxstep.
&sum{ftimeAtStep(T1) + MinDur} = ftimeAtStep(T2) :- minDuration(MinDur), happens(switch_right, T1), T1 < maxstep, happens(aux__endMinDurRightFilling(T1), T2).
&sum{ftimeAtStep(T1) + MinDur} = ftimeAtStep(T2) :- minDuration(MinDur), happens(start(right), T1), T1 < maxstep, happens(aux__endMinDurRightFilling(T1), T2).

{happens(aux__endMinDurLeftFilling(T1), T2) : time(T2), T2 > T1} = 1 :- happens(switch_left, T1), T1 < maxstep.
{happens(aux__endMinDurLeftFilling(T1), T2) : time(T2), T2 > T1} = 1 :- happens(start(left), T1), T1 < maxstep.
&sum{ftimeAtStep(T1) + MinDur} = ftimeAtStep(T2) :- minDuration(MinDur), happens(switch_left, T1), T1 < maxstep, happens(aux__endMinDurLeftFilling(T1), T2).
&sum{ftimeAtStep(T1) + MinDur} = ftimeAtStep(T2) :- minDuration(MinDur), happens(start(left), T1), T1 < maxstep, happens(aux__endMinDurLeftFilling(T1), T2).


% ----- narrative & queries  -----

initiallyP(water_left, 100).
initiallyP(water_right, 100).
initiallyN(F) :- not initiallyP(F), dfluent(F).

in_happens(start(right),           10).

% for maxstep 14 without laststep
% happens(switch_left,25/2)
% happens(switch_left,145/8)
% happens(switch_left,161/8)
% happens(switch_left,177/8)
% happens(switch_right,65/4)
% happens(switch_right,153/8)
% happens(switch_right,169/8)
% happens(aux__endMinDurLeftFilling(3),27/2)
% happens(aux__endMinDurLeftFilling(7),153/8)
% happens(aux__endMinDurLeftFilling(11),169/8)
% happens(aux__endMinDurRightFilling(1),11)
% happens(aux__endMinDurRightFilling(5),69/4)
% happens(aux__endMinDurRightFilling(9),161/8)
% happens(aux__endMinDurRightFilling(13),177/8)
% happens(start(right),10)