% Based on: Carrying a book example -- using effect constraints
% from T.Mueller, 2014 - Commonsense reasoning - an event calculus based approach
% based on page 99, section 6.4.1
%
% Demonstrates indirect effects using effect constraints
%
% Modified for clingo-lpx --> location is a continuous location instead of a room (non-ground value)

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

event(walk(A, L)) :- agent(A), in_locations(L).
event(pickUp(A, O)) :- agent(A), object(O).
event(letGoOf(A, O)) :- agent(A), object(O).


%-------------------------------------------------------------------------------
% effects 
%-------------------------------------------------------------------------------

% if an agent walks from Location1 to Location2, then they will no longer be in Location1
% and will be in Location2
initiates(walk(A, L), location(A), (L, 1, 0, location(A)), T) :- time(T), agent(A), in_locations(L).

% if an agent is in the same room as an object and picks it up, then they will be holding it
initiates(pickUp(A, O), holding(A, O), T) :-
    normal_atom(fholdsAt(location(A), T), eq, fholdsAt(location(O), T)),
    agent(A), object(O), time(T).
comparison(fholdsAt(location(A), T), fholdsAt(location(O), T)) :- happens(pickUp(A, O), T).

%% % if an agent is holding an object and lets go of it, then they will no longer be holding it
terminates(letGoOf(A, O), holding(A, O), T) :-
    holdsAt(holding(A, O), T),
    agent(A), object(O), time(T).


%-------------------------------------------------------------------------------
% state constraints
%-------------------------------------------------------------------------------

% % an object can only be in one room at a time (same for agents...)
% R1=R2 :- holdsAt(location(O,R1), T), holdsAt(location(O,R2), T),
%     object(A), room(R1), room(R2), time(T).
% R1=R2 :- holdsAt(location(A,R1), T), holdsAt(location(A,R2), T),
%     agent(A), room(R1), room(R2), time(T).


%-------------------------------------------------------------------------------
% effect constraints
%-------------------------------------------------------------------------------

%! indirect effect
% TODO maybe the (A,B,C,F) should be (A,B,C,F1,F2)
% TODO axioms would then have &sum{ A; B*(fholdsAt(F1,T) + C) } = fholdsAt(F2,T+1)
initiates(E, location(O), (FA1, FA2, FB, location(O)), T) :-
    holdsAt(holding(A, O), T),
    initiates(E, location(A), (FA1, FA2, FB, location(A)), T),
    time(T), object(O).


%-------------------------------------------------------------------------------
% triggered events
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% release from CLoI
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% observations
%-------------------------------------------------------------------------------

initiallyP(location(nathan), 0).
initiallyP(location(book), 0).
initiallyN(F) :- not initiallyP(F), dfluent(F).  % % nathan is initially not holding the book


%-------------------------------------------------------------------------------
% narrative 
%-------------------------------------------------------------------------------

in_happens(pickUp(nathan, book), 10).

% nathan walks to position 100 with the book
in_happens(walk(nathan, 100), 20).

in_happens(letGoOf(nathan, book), 30).

% nathan walks to position 200 without the book
in_happens(walk(nathan, 200), 40).

% --> conclude that the book is at position 100 after time 20 and stays there 
