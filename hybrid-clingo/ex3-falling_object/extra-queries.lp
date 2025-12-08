% exploring ways to query fluents values

#const maxstep=6.
#const maxtime=1000.


%-------------------------------------------------------------------------------
% additional "queries"
%-------------------------------------------------------------------------------

% TODO if we wanted to check the height at time 15
% could add an event at time 15
in_happens(checkAtT, 15).                   
%% or can use this (there is one checkStep such that its time is 15 -- check steps do not need to have an event)
%{checkStep(T) : time(T)} = 1.
%&sum{ ftimeAtStep(T) } = 15 :- checkStep(T).
%% or can maybe use this
%checkStep(T) :- normal_atom(ftimeAtStep(T), eq, 15), time(T).
%trigger_time(15).


% TODO if we wanted to see the time at which the height is 2
% could add a triggered event
happens(checkAtH, T) :- normal_atom(fholdsAt(height(O), T), eq, 2), time(T).
trigger_value(height(O), 2) :- object(O).
%% or can use this (there is one checkStep such that the height is 2)
%{checkStep(T) : time(T)} = 1.
%&sum{ fholdsAt(height(apple), T) } = 2 :- checkStep(T).
%% or a hybrid
%checkStep(T) :- normal_atom(fholdsAt(height(O), T), eq, 2), time(T).
%trigger_value(height(O), 2) :- object(O).


% TODO if we wanted to see the time at which the object was falling for 2 time units
%% could hard code this using ground time
%in_happens(checkAtDur, T + 2) :- in_happens(drop(nathan,apple), T).
%% or could use non-ground time (should be more general)
%{happens(checkAtDur(T1), T2) : time(T2), T2 > T1} = 1 :- happens(drop(nathan,apple), T1), T1 < maxstep.
%&sum{ftimeAtStep(T1) + 2} = ftimeAtStep(T2) :- happens(drop(nathan,apple), T1), T1 < maxstep, happens(checkAtDur(T1), T2).
%% or this
%{happens(checkAtDur(T1, O), T2) : time(T2), T2 > T1} = 1 :- happens(E, T1), initiates(E, falling(O), T1), T1 < maxstep.
%&sum{ftimeAtStep(T1) + 2} = ftimeAtStep(T2) :- happens(E, T1), initiates(E, falling(O), T1), T1 < maxstep, happens(checkAtDur(T1, O), T2).
%% or could use a checkStep instead
%{checkStep(T) : time(T)} = 1.
%&sum{ftimeAtStep(T1) + 2} = ftimeAtStep(T2) :- happens(drop(nathan,apple), T1), T1 < maxstep, checkStep(T2).
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
    normal_atom(timeDiff(T1,T), eq, Dur),
        %normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), eq, Dur),
    time(T1), time(T).
comparison(timeDiff(T1,T), Dur) :- checkDuration(Dur), T1 <= T, time(T1), time(T).
    %comparison(ftimeAtStep(T), -ftimeAtStep(T1), Dur) :- checkDuration(Dur), T1 < T, time(T1), time(T).
:-  T1 <= T+1,
    happens(E, T1),
    initiates(E, falling(O), T1),
    not stoppedIn(T1, falling(O), T+1),
    time(T1), time(T),
    checkDuration(Dur),
    normal_atom(timeDiff(T1,T), lt, Dur),
    normal_atom(timeDiff(T1,T+1), gt, Dur),
        % normal_atom(ftimeAtStep(T), -ftimeAtStep(T1), lt, Dur),
        % normal_atom(ftimeAtStep(T+1), -ftimeAtStep(T1), gt, Dur),
    time(T), time(T+1).

