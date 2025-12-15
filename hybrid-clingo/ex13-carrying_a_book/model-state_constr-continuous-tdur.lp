% Carrying a book example -- using release axioms and state constrains
% from T.Mueller, 2014 - Commonsense reasoning - an event calculus based approach
% based on page 96, section 6.3.1
%
% Demonstrates indirect effects using release axioms and state constrains
%
% Modified for clingo-lpx --> location is a continuous location instead of a room (non-ground value)
% and walking is now a continuous process via a trajectory
% TODO currently can only walk in one direction (only up/forward)

%-------------------------------------------------------------------------------
% sorts
%-------------------------------------------------------------------------------

agent(nathan).
object(book).
%! could also use (below) to treat agents as objects
% object(A) :- agent(A).

in_locations(L) :- in_happens(walk(_, L), _).  % grounding L only to actual occurrences

ffluent(location(A)) :- agent(A).
ffluent(location(O)) :- object(O).
dfluent(holding(A, O)) :- agent(A), object(O).
dfluent(walking(A)) :- agent(A).
ffluent(walkingTo(A)) :- agent(A).

event(walk(A, L)) :- agent(A), in_locations(L).
event(arrive(A)) :- agent(A).
event(pickUp(A, O)) :- agent(A), object(O).
event(letGoOf(A, O)) :- agent(A), object(O).


%-------------------------------------------------------------------------------
% effects 
%-------------------------------------------------------------------------------

% if an agent starts walking from Location1 to Location2, then they will no longer be in Location1,
% will be walking, and their location will continuously approach Location2
initiates(walk(A, L), walking(A), T) :- step(T), agent(A), in_locations(L).
initiates(walk(A, L), walkingTo(A), (L, 1, 0, walkingTo(A)), T) :- step(T), agent(A), in_locations(L).    % TODO need a second fluent because trajectories can only be controlled by dfluents
&sum{0} = (walkingTo(A),T) :- not holdsAt(walking(A), T), step(T), agent(A).

releases(walk(A, L), location(A), T) :- agent(A), step(T), in_locations(L).

terminates(arrive(A), walking(A), T) :- agent(A), step(T).
%terminates(arrive(A), walkingTo(A), T) :- agent(A), step(T).
initiates(arrive(A), walkingTo(A), (0,0,0,walkingTo(A)), T) :- agent(A), step(T).

initiates(arrive(A), location(A), (0, 0, 1, location(A)), T) :- step(T), agent(A).

trajectory(walking(A), T1, location(A), (0, 0, 1, location(A), 10), timeDiff(T1, T2)) :- T1 < T2, agent(A), step(T1), step(T2).
% trajectory(walkingTo(A), T1, location(A), (0, 0, 1, location(A), 10), timeDiff(T1, T2)) :- T1 < T2, agent(A), step(T1), step(T2).

happens(arrive(A), T) :-
    holdsAt(walking(A), T), % holdsAt(walkingTo(A), T),
    normal_atom((location(A), T), eq, (walkingTo(A), T)), 
    step(T).
% TODO trigger_value for two func fluents
comparison((location(A), T), (walkingTo(A), T)) :- agent(A), step(T).
% TODO this constraint doesnt really work
% TODO at T location might be 100 and walkingTo is 0 (not holds), and then at T+1 location might be 150 and walkingTo 200 -- killing the model (at T 100 > 0 and at T+1 150 < 200)
% TODO the problem is that walkingTo is initiated at T to value 200 buts its value is still 0 at T
    %:- holdsAt(walking(A), T+1), normal_atom((location(A), T), gt, (walkingTo(A), T)), normal_atom((location(A), T+1), lt, (walkingTo(A), T+1)), step(T), step(T+1).
    %:- holdsAt(walking(A), T+1), normal_atom((location(A), T), lt, (walkingTo(A), T)), normal_atom((location(A), T+1), gt, (walkingTo(A), T+1)), step(T), step(T+1).
%% either the agent is already walking at T
:- holdsAt(walking(A), T), holdsAt(walking(A), T+1), normal_atom((location(A), T), gt, (walkingTo(A), T)), normal_atom((location(A), T+1), lt, (walkingTo(A), T+1)), step(T), step(T+1).
:- holdsAt(walking(A), T), holdsAt(walking(A), T+1), normal_atom((location(A), T), lt, (walkingTo(A), T)), normal_atom((location(A), T+1), gt, (walkingTo(A), T+1)), step(T), step(T+1).
%% or the agent just started walking at T
:- happens(walk(A, L), T), initiates(walk(A, L), walking(A), T), holdsAt(walking(A), T+1), normal_atom((location(A), T), gt, L), normal_atom((location(A), T+1), lt, (walkingTo(A), T+1)), step(T), step(T+1).
:- happens(walk(A, L), T), initiates(walk(A, L), walking(A), T), holdsAt(walking(A), T+1), normal_atom((location(A), T), lt, L), normal_atom((location(A), T+1), gt, (walkingTo(A), T+1)), step(T), step(T+1).

% if an agent is in the same room as an object and picks it up, then they will be holding it
initiates(pickUp(A, O), holding(A, O), T) :-
    normal_atom((location(A), T), eq, (location(O), T)),
    agent(A), object(O), step(T).
comparison((location(A), T), (location(O), T)) :- happens(pickUp(A, O), T).

%% % if an agent is holding an object and lets go of it, then they will no longer be holding it
terminates(letGoOf(A, O), holding(A, O), T) :-
    holdsAt(holding(A, O), T),
    agent(A), object(O), step(T).

%! indirect effect
% if an agent lets go of an object while in a room, then the object will be
% in that room and will no longer be released from CLoI (caused by initiates)
initiates(letGoOf(A, O), location(O), ((location(A),T), 1, 0, location(O)), T) :- step(T), agent(A), object(O).


%-------------------------------------------------------------------------------
% state constraints
%-------------------------------------------------------------------------------

% % an object can only be in one room at a time (same for agents...)
% R1=R2 :- holdsAt(location(O,R1), T), holdsAt(location(O,R2), T),
%     object(A), room(R1), room(R2), step(T).
% R1=R2 :- holdsAt(location(A,R1), T), holdsAt(location(A,R2), T),
%     agent(A), room(R1), room(R2), step(T).

%! indirect effect
% when an agent is in a room and holding an object, then the object is in the same room
&sum{(location(A),T)} = (location(O),T) :-
    holdsAt(holding(A,O), T),
    agent(A), object(O), step(T).


%-------------------------------------------------------------------------------
% triggered events
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% release from CLoI
%-------------------------------------------------------------------------------

%! indirect effect
% when an agent pickups an object, then the location of that object will
% be released from CLoI
releases(pickUp(A,O), location(O), T) :-
    agent(A), object(O), step(T).

%-------------------------------------------------------------------------------
% observations
%-------------------------------------------------------------------------------

initiallyP(location(nathan), 0).
initiallyP(location(book), 0).
initiallyN(F) :- not initiallyP(F), dfluent(F).  % nathan is initially not holding the book and % nathan is initially not walking
:- releasedAt(F,0), fluent(F).  % nothing is initially released from inertia


%-------------------------------------------------------------------------------
% narrative 
%-------------------------------------------------------------------------------

in_happens(pickUp(nathan, book), 10).

% nathan walks to position 100 with the book
in_happens(walk(nathan, 100), 20).

% check state of fluents at time 25
in_happens(check, 25).

% --> conclude arrive at 30

in_happens(letGoOf(nathan, book), 40).
 
% nathan walks to position 200 without the book
in_happens(walk(nathan, 200), 50).

% check state of fluents at time 55
in_happens(check, 55).

% --> conclude arrive at 60
