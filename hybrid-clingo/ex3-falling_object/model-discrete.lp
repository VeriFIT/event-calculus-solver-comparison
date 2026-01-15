% Falling object example -- continuous change using trajectory
% from T.Mueller, 2014 - Commonsense reasoning - an event calculus based approach
% based on page 121, section 7.1.3
%
% An object is dropped, falls down via a constant speed, and then stops falling when it hits the floor.

#const maxstep=3.
#const maxtime=1000.


%-------------------------------------------------------------------------------
% sorts
%-------------------------------------------------------------------------------

agent(nathan).
object(apple).
fHeight(-paramHeight..paramHeight).

fluent(height(O, H)) :- object(O), fHeight(H).
fluent(falling(O)) :- object(O).

event(drop(A, O)) :- agent(A), object(O).
event(hitGround(O)) :- object(O).

#const paramHeight=100.
initHeight(paramHeight).
fGravity(2).


%-------------------------------------------------------------------------------
% domain description 
%-------------------------------------------------------------------------------

% [effect]
% if an agent drops an object, then the object will start falling and its height
% will be released from CLoI
initiates(drop(A,O), falling(O), T) :- agent(A), object(O), step(T).

% [effect + CLoI]
releases(drop(A,O), height(O, H), T) :- agent(A), object(O), fHeight(H), step(T).

% [triggered event]
% an object hits the ground when its falling and its height becomes zero
happens(hitGround(O), T) :-
    holdsAt(falling(O), T),
    holdsAt(height(O,0), T).

% capture when height(O, 0)
:- holdsAt(height(O,H1), S-1), H1 < 0, holdsAt(height(O,H2), S), H2 > 0.
:- holdsAt(height(O,H1), S-1), H1 > 0, holdsAt(height(O,H2), S), H2 < 0.

% [effect]
% if an object hits the ground, then it will stop falling
terminates(hitGround(O), falling(O), T) :- object(O), step(T).

% [effect + CLoI]
% if an object hits the ground then its height will no longer be released from CLoI
initiates(hitGround(O), height(O, H), T) :- holdsAt(height(O, H), T).

% TODO % terminates(catch(A, O), falling(O), T) :- agent(A), object(O), step(T).
% TODO % 
% TODO % &sum{ (height(O),T) } = (height(O),T+1) :- 
% TODO %     happens(catch(A, O), T),
% TODO %     agent(A), step(T).
% TODO % 
% TODO % defined((height(O),T+1)) :- 
% TODO %     happens(catch(A, O), T),
% TODO %     agent(A), step(T).


% [state constraint]
% an object only has one unique height at a time
H1 = H2 :- holdsAt(height(O,H1), T), holdsAt(height(O,H2), T).

% motion of an object from the moment it is dropped to the moment it hits the ground
trajectory(falling(O), T1, height(O,Res), T2) :-
    0 < T2,
    holdsAt(height(O,H), T1),
    &sum{(timeDiff, T1, T1+T2)} = Duration,
    fHeight(Res),
    Duration = (Res - H) / (-1),    % TODO for some reason -2 gives unsat, dont have time to explore further....
    fGravity(G), object(O), fHeight(H), step(T1), step(T2), step(T1+T2).

% TODO this is needed otherwise the value of height will be released and non-deterministic when the values of Duration go beyond the domain fHeight
% TODO in that case the trajectory predicate will be false, therefore will not define any value for F2
:- holdsAt(falling(O), S), not anyFallingTrajectory(S).
anyFallingTrajectory(S) :- trajectory(falling(O), _, _, S), step(S).

%-------------------------------------------------------------------------------
% narrative 
%-------------------------------------------------------------------------------

initiallyP(height(apple, H)) :- initHeight(H).  % apples height initially is something
initiallyN(falling(apple)).
%initiallyN(F) :- not initiallyP(F), fluent(F).  % apple is initially not falling
:- releasedAt(F,0), fluent(F).  % nothing is initially released from inertia
:- releasedAt(F,0), ffluent(F). % nothing is initially released from inertia

obs(happens(drop(nathan,apple)), 10).        % nathan drop the apple at time 10
% obs(happens(catch(nathan,apple)), 15).     % TODO could add this to prevent hitting the ground 

% --> conclude that the apple will hit the ground at time (initHeight/2) + 10