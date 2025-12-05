% roll a dice with non-ground number of sides
% testing release from inertia for functional fluents

%-------------------------------------------------------------------------------
% sorts
%-------------------------------------------------------------------------------

event(roll).
event(land).

ffluent(sideUp).    % functional fluent

% the fluent can only have positive fholdsAts
&sum{ fholdsAt(sideUp, T) } > 0 :- holdsAt(sideUp, T), not releasedAt(sideUp, T), time(T).


%-------------------------------------------------------------------------------
% effects 
%-------------------------------------------------------------------------------

releases(roll, sideUp, T) :- time(T).

initiates(land, sideUp, (0, 1, 1, sideUp), T) :- time(T).


%-------------------------------------------------------------------------------
% state constraints
%-------------------------------------------------------------------------------

% the dice must always be exactly one of the sides up
% 1{holdsAt(sideUp, T)}1 :- time(T).

%-------------------------------------------------------------------------------
% observations
%-------------------------------------------------------------------------------

initiallyP(sideUp, 1).
%initiallyN(F) :- not initiallyP(F), dfluent(F).


%-------------------------------------------------------------------------------
% narrative 
%-------------------------------------------------------------------------------

in_happens(roll,      10).
in_happens(land,      20). % TODO could be triggered


% enforce a result that we are looking for
% (since its not really useful to list all non-ground fholdsAts...)
&sum{ fholdsAt(sideUp, 3) } = X :- goal(X).

% TODO the goal is grounded but the point of the example is to show a non-ground non-deterministic fholdsAt during the roll
{goal(1;2;3;4;5;6)} = 1.
