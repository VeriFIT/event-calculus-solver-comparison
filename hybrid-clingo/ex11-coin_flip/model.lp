% toss a coin that will non-deterministically land as heads or tails
% testing release from inertia for discrete fluents

%-------------------------------------------------------------------------------
% sorts
%-------------------------------------------------------------------------------

event(toss).
event(land).

dfluent(up(heads)).
dfluent(up(tails)).


%-------------------------------------------------------------------------------
% effects 
%-------------------------------------------------------------------------------

releases(toss,  up(X), T) :- fluent(up(X)), step(T).

initiates(land, up(X), T) :- holdsAt(up(X), T), step(T).
terminates(land, up(X), T) :- not holdsAt(up(X), T), step(T), fluent(up(X)).


%-------------------------------------------------------------------------------
% state constraints
%-------------------------------------------------------------------------------

% the coin must always be exactly one of the sides up
1{holdsAt(up(X), T) : fluent(up(X))}1 :- step(T).

%-------------------------------------------------------------------------------
% observations
%-------------------------------------------------------------------------------

initiallyP(up(heads)).
initiallyN(F) :- not initiallyP(F), dfluent(F).
:- releasedAt(F,0), fluent(F).  % nothing is initially released from inertia


%-------------------------------------------------------------------------------
% narrative 
%-------------------------------------------------------------------------------

in_happens(toss,      10).
in_happens(land,      20). % TODO could be triggered

% --> two models heads or tails
