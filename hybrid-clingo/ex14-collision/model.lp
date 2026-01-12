% There are two objects. One is dropped from a height and is falling. The other is thrown up and is rising.
% The reasoning should find that the two object collide.
% After collision, both objects stop moving and remain stationary (for simplicity)

#const maxstep=3.
#const maxtime=1000.


%-------------------------------------------------------------------------------
% sorts
%-------------------------------------------------------------------------------

agent(nathan1).
agent(nathan2).
object(apple).
object(ball).
% fHeight(-paramHeight..paramHeight).

% fluent(height(O, H)) :- object(O), fHeight(H).
ffluent(height(O)) :- object(O).
fluent(falling(O)) :- object(O).
fluent(rising(O)) :- object(O).

event(drop(A, O)) :- agent(A), object(O).
event(throw(A, O)) :- agent(A), object(O).
event(collide(O1, O2)) :- object(O1), object(O2).

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

% similar for throw
initiates(throw(A,O), rising(O), T) :- agent(A), object(O), step(T).

% [effect + CLoI]
releases(drop(A,O), height(O), T) :- agent(A), object(O), step(T).

% similar for throw
releases(throw(A,O), height(O), T) :- agent(A), object(O), step(T).

% [triggered event]
% an object hits the ground when its falling and its height becomes zero
happens(collide(O1, O2), T) :-
    holdsAt(falling(O1), T),
    holdsAt(rising(O2), T),
    sum( ( (1,(height(O1), T)), (-1,(height(O2), T)) ), eq, 0), 
    step(T).


% restrict that there must exist a state where the heights are exactly equal
% TODO manual no_jump
comparison(( (1,(height(O1), S)), (-1,(height(O2), S)) ), 0) :- object(O1), object(O2), step(S).
:- holdsAt(falling(O1), S+1), holdsAt(rising(O2), S+1),
    sum(( (1,(height(O1), S)), (-1,(height(O2), S)) ), gt, 0), sum(( (1,(height(O1), S+1)), (-1,(height(O2), S+1)) ), lt, 0), step(S), step(S+1).
:- holdsAt(falling(O1), S+1), holdsAt(rising(O2), S+1),
    sum(( (1,(height(O1), S)), (-1,(height(O2), S)) ), lt, 0), sum(( (1,(height(O1), S+1)), (-1,(height(O2), S+1)) ), gt, 0), step(S), step(S+1).


% [effect]
terminates(collide(O1, O2), falling(O1), T) :- object(O1), object(O2), step(T).
terminates(collide(O1, O2), rising(O2), T) :- object(O1), object(O2), step(T).

% [effect + CLoI]
initiates(collide(O1,O2), height(O1), ((1, (height(O1),T))), T) :- step(T), object(O1), object(O2).
initiates(collide(O1,O2), height(O2), ((1, (height(O2),T))), T) :- step(T), object(O1), object(O2).

% [state constraint]
% an object only has one unique height at a time
% H1 = H2 :- holdsAt(height(O,H1), T), holdsAt(height(O,H2), T),
%     agent(A), object(O), fHeight(H1), fHeight(H2), step(T).
% TODO not needed since clingo lpx only allows one functional value at a time

% motion of an object from the moment it is dropped to the moment it hits the ground
%*
%trajectory(falling(O), T1, height(O,H - (G)*(T2-T1)), T2) :-
%    T1 < T2,
%    holdsAt(height(O,H), T1),
%    fGravity(G), object(O), fHeight(H), step(T1), step(T2).
*%
trajectory(falling(O), T1, height(O), ( (1, (height(O), T1)), (2, (time, T1)), (-2, (time, T3)) ), T2) :-
    T3 = T1+T2, step(T3), object(O), step(T1), step(T2).
trajectory(rising(O), T1, height(O), ( (1, (height(O), T1)), (-2, (time, T1)), (2, (time, T3)) ), T2) :-
    T3 = T1+T2, step(T3), object(O), step(T1), step(T2).


%-------------------------------------------------------------------------------
% narrative 
%-------------------------------------------------------------------------------

initiallyP(height(apple), H) :- initHeight(H).  % apple's height initially is something
initiallyP(height(ball), 0).                    % ball's height initially is something
initiallyN(falling(O)) :- object(O).
initiallyN(rising(O)) :- object(O).
:- releasedAt(F,0), fluent(F).  % nothing is initially released from inertia
:- releasedAt(F,0), ffluent(F). % nothing is initially released from inertia

obs(happens(drop(nathan1,apple)), 10).        % nathan1 drop the apple at time 10
obs(happens(throw(nathan2,ball)), 10).        % nathan2 throws the ball at time 10

% --> conclude ...