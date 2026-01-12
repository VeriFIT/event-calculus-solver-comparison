
% ----- domain model -----

event(turn_light_on).
event(turn_light_off).

fluent(light_on).

initiates(turn_light_on,  light_on, T) :- step(T).
terminates(turn_light_off, light_on, T) :- step(T).

% time epsilon to trigger on/off(A)
epsilon(1). % integer for clingcon

happens(turn_light_off, T) :- holdsAt(light_on, T),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    initiates(E, light_on, T1),
    not stoppedIn(T1, light_on, T),
    epsilon(EPS),
    sum( ( (1, (timeDiff, T1, T)) ), eq, EPS),
    step(T).

happens(turn_light_on, T) :- not holdsAt(light_on, T), step(T),
    % TODO would be nicer if hidden behind holdsAt/3
    T1 < T,
    happens(E, T1),
    terminates(E, light_on, T1),
    not startedIn(T1, light_on, T),
    epsilon(EPS),
    sum( ( (1, (timeDiff, T1, T)) ), eq, EPS),
        %sum(time(T), -time(T1), eq, EPS),
    T > 1, step(T).


comparison( ( (1, (timeDiff, T1, T)) ), EPS) :- epsilon(EPS), T1 <= T, step(T1), step(T).
    %comparison(time(T), -time(T1), EPS) :- epsilon(EPS), T1 < T, step(T1), step(T).


% TODO complicated trigger_value
% cannot step over T1 + epsilon
:-  % establish T1
    happens(E, T1),
    initiates(E, light_on, T1),
    not stoppedIn(T1, light_on, T+1),
    % cannot step over T1 + EPS
    T >= T1,
    epsilon(EPS),
    sum(( (1, (timeDiff, T1, T)) ), lt, EPS),
    sum(( (1, (timeDiff, T1, T+1)) ), gt, EPS),
    % if the trigger condition holds
    holdsAt(light_on, T+1).
:-  % establish T1 (cause 2)
    happens(E, T1),
    terminates(E, light_on, T1),
    not startedIn(T1, light_on, T+1),
    % cannot step over it
    T >= T1,
    epsilon(EPS),
    sum(( (1, (timeDiff, T1, T)) ), lt, EPS),
    sum(( (1, (timeDiff, T1, T+1)) ), gt, EPS),
    % if the trigger condition holds
    not holdsAt(light_on, T+1).

%% % TODO complicated trigger_value
%% % cannot step over T1 + epsilon
%% :-  % establish T1 (cause 1)
%%     happens(E, T1),
%%     initiates(E, light_on, T1),
%%     not stoppedIn(T1, light_on, T+1),
%%     % cannot step over it
%%     T > T1,
%%     epsilon(EPS),
%%     sum(time(T), -time(T1), lt, EPS),
%%     sum(time(T+1), -time(T1), gt, EPS),
%%     % if the trigger condition holds
%%     holdsAt(light_on, T).
%% :-  % establish T1 (cause 2)
%%     happens(E, T1),
%%     terminates(E, light_on, T1),
%%     not startedIn(T1, light_on, T+1),
%%     % cannot step over it
%%     T > T1,
%%     epsilon(EPS),
%%     sum(time(T), -time(T1), lt, EPS),
%%     sum(time(T+1), -time(T1), gt, EPS),
%%     % if the trigger condition holds
%%     not holdsAt(light_on, T).
%% % TODO need a special case for T = T1 + 1 because &sum{step(T) - step(T)} < EPS is unsat
%% :-  % establish T1 (cause 1)
%%     happens(E, T1),
%%     initiates(E, light_on, T1),
%%     % cannot step over it
%%     T = T1,
%%     epsilon(EPS),
%%     sum(time(T+1), -time(T1), gt, EPS),
%%     % if the trigger condition holds
%%     holdsAt(light_on, T+1).
%% :-  % establish T1 (cause 2)
%%     happens(E, T1),
%%     terminates(E, light_on, T1),
%%     % cannot step over it
%%     T = T1,
%%     epsilon(EPS),
%%     sum(time(T+1), -time(T1), gt, EPS),
%%     % if the trigger condition holds
%%     not holdsAt(light_on, T+1).

% ----- narrative & queries  -----
initiallyN(light_on).
:- releasedAt(F,0), fluent(F).  % nothing is initially released from inertia
:- releasedAt(F,0), ffluent(F). % nothing is initially released from inertia

obs(happens(turn_light_on),      10).
