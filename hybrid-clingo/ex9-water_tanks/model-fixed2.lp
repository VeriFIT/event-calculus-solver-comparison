
% ----- domain model -----

ffluent(water_left).
ffluent(water_right).
dfluent(left_filling).
dfluent(right_filling).  % replaced left_draining

event(start(left)).
event(start(right)).
event(switch_left).
event(switch_right).

initiates(start(left), left_filling, T) :- step(T).
initiates(start(right), right_filling, T) :- step(T).
releases(start(LR), water_left, T) :- step(T), event(start(LR)).
releases(start(LR), water_right, T) :- step(T), event(start(LR)).

initiates(switch_left, left_filling, T) :- step(T).
terminates(switch_left, right_filling, T) :- step(T).

terminates(switch_right, left_filling, T) :- step(T).
initiates(switch_right, right_filling, T) :- step(T).

trajectory(left_filling, T1, water_left, (0, 1, 1, water_left, TotalFlow), T2) :-
    TotalFlow = 30 - 20, % in rate 30, out rate 20
    step(T1), step(T2).

trajectory(right_filling, T1, water_left, (0, 1, 1, water_left, -TotalFlow), T2) :-
    TotalFlow = 20, % out rate 20
    step(T1), step(T2).

trajectory(right_filling, T1, water_right, (0, 1, 1, water_right, TotalFlow), T2) :-
    TotalFlow = 30 - 20, % in rate 30, out rate 20
    step(T1), step(T2).

trajectory(left_filling, T1, water_right, (0, 1, 1, water_right, -TotalFlow), T2) :-
    TotalFlow = 20, % out rate 20
    step(T1), step(T2).

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
        step(T),
    happens(aux__endMinDurRightFilling(T1), T2), T1 < T2, T2 <= T,
    normal_atom((water_left, T), eq, 50). % target level

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
        step(T),
    happens(aux__endMinDurRightFilling(T1), T),
    normal_atom((water_left, T), lt, 50). % target level
%comparison((water_left, T), 50) :- step(T).

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
        step(T),
    happens(aux__endMinDurLeftFilling(T1), T2), T1 < T2, T2 <= T,
    normal_atom((water_right, T), eq, 50). % target level
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
        step(T),
    happens(aux__endMinDurLeftFilling(T1), T),
    normal_atom((water_right, T), lt, 50). % target level
%comparison((water_right, T), 50) :- step(T).

% this is needed bc of the leq above
trigger_value(water_left, right_filling, 50).
trigger_value(water_right, left_filling, 50).

% TODO this needs to be discussed -- no all steps with water level 50 will have an event, therefore, make all of them checkSteps
checkStep(T) :- step(T), holdsAt(right_filling, T), normal_atom((water_left, T), eq, 50).
checkStep(T) :- step(T), holdsAt(left_filling, T), normal_atom((water_right, T), eq, 50).

% TODO this needs to be discussed -- a way to track minimal duration of a trajectory
% TODO this works but requires steps to be incremented by 2 (model at N, no model at N+1, model at N+2)
% trying to trigger an event MinDur time after switch_left/right happens
{happens(aux__endMinDurRightFilling(T1), T2) : step(T2), T2 > T1} = 1 :- happens(switch_right, T1), T1 < maxstep.
{happens(aux__endMinDurRightFilling(T1), T2) : step(T2), T2 > T1} = 1 :- happens(start(right), T1), T1 < maxstep.
&sum{time(T1) + MinDur} = time(T2) :- minDuration(MinDur), happens(switch_right, T1), T1 < maxstep, happens(aux__endMinDurRightFilling(T1), T2).
&sum{time(T1) + MinDur} = time(T2) :- minDuration(MinDur), happens(start(right), T1), T1 < maxstep, happens(aux__endMinDurRightFilling(T1), T2).

{happens(aux__endMinDurLeftFilling(T1), T2) : step(T2), T2 > T1} = 1 :- happens(switch_left, T1), T1 < maxstep.
{happens(aux__endMinDurLeftFilling(T1), T2) : step(T2), T2 > T1} = 1 :- happens(start(left), T1), T1 < maxstep.
&sum{time(T1) + MinDur} = time(T2) :- minDuration(MinDur), happens(switch_left, T1), T1 < maxstep, happens(aux__endMinDurLeftFilling(T1), T2).
&sum{time(T1) + MinDur} = time(T2) :- minDuration(MinDur), happens(start(left), T1), T1 < maxstep, happens(aux__endMinDurLeftFilling(T1), T2).


% ----- narrative & queries  -----

initiallyP(water_left, 100).
initiallyP(water_right, 100).
initiallyN(F) :- not initiallyP(F), dfluent(F).
:- releasedAt(F,0), fluent(F).  % nothing is initially released from inertia

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