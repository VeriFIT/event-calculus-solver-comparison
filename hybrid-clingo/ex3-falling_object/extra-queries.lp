% exploring ways to query fluents values

#const maxstep=6.
#const maxtime=1000.


%-------------------------------------------------------------------------------
% additional "queries"
%-------------------------------------------------------------------------------

% TODO if we wanted to check the height at time 15
% could add an event at time 15
obs(happens(checkAtT), 15).                   
%% or can use this (there is one checkStep such that its time is 15 -- check steps do not need to have an event)
%{checkStep(T) : step(T)} = 1.
%&sum{ time(T) } = 15 :- checkStep(T).
%% or can maybe use this
%checkStep(T) :- sum(time(T), eq, 15), step(T).
%trigger_time(15).


% TODO if we wanted to see the time at which the height is 2
% could add a triggered event
happens(checkAtH, T) :- sum(( (1, (height(O), T)) ), eq, 2), step(T).
no_jump(height(O), S, 2) :- holdsAt(falling(O), S).
%% or can use this (there is one checkStep such that the height is 2)
%{checkStep(T) : step(T)} = 1.
%&sum{ (height(apple), T) } = 2 :- checkStep(T).
%% or a hybrid
%checkStep(T) :- sum((height(O), T), eq, 2), step(T).
%trigger_value(height(O), 2) :- object(O).


% TODO if we wanted to see the time at which the object was falling for 2 time units
%% could hard code this using ground time
%in_happens(checkAtDur, T + 2) :- in_happens(drop(nathan,apple), T).
%% or could use non-ground time (should be more general)
%{happens(checkAtDur(T1), T2) : step(T2), T2 > T1} = 1 :- happens(drop(nathan,apple), T1), T1 < maxstep.
%&sum{time(T1) + 2} = time(T2) :- happens(drop(nathan,apple), T1), T1 < maxstep, happens(checkAtDur(T1), T2).
%% or this
%{happens(checkAtDur(T1, O), T2) : step(T2), T2 > T1} = 1 :- happens(E, T1), initiates(E, falling(O), T1), T1 < maxstep.
%&sum{time(T1) + 2} = time(T2) :- happens(E, T1), initiates(E, falling(O), T1), T1 < maxstep, happens(checkAtDur(T1, O), T2).
%% or could use a checkStep instead
%{checkStep(T) : step(T)} = 1.
%&sum{time(T1) + 2} = time(T2) :- happens(drop(nathan,apple), T1), T1 < maxstep, checkStep(T2).
% or this
checkDuration(2).
happens(checkAtDur, T) :-
    holdsAt(falling(O), T),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    initiates(E, falling(O), T1),
    not stoppedIn(T1, falling(O), T),
    checkDuration(Dur),
    sum(( (1, (timeDiff, T1, T)) ), eq, Dur),
    step(T1), step(T).

comparison( ( (1, (timeDiff, T1, T)) ), Dur) :- checkDuration(Dur), T1 <= T, step(T1), step(T).
:-  % establish T1
    happens(E, T1),
    initiates(E, falling(O), T1),
    not stoppedIn(T1, falling(O), T+1),
    % cannot step over T1 + Dur
    T >= T1,
    checkDuration(Dur),
    sum(( (1, (timeDiff, T1, T)) ), lt, Dur),
    sum(( (1, (timeDiff, T1, T+1)) ), gt, Dur).