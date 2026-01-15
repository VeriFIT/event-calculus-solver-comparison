% counter example from Mueller, E. T. Chapter 17 event calculus. In Handbook of Knowledge Representation 2008

#const maxstep=5.
#const maxtime=1000.

%-------------------------------------------------------------------------------
% sorts
%-------------------------------------------------------------------------------

event(increment).
event(reset).

ffluent(value).


%-------------------------------------------------------------------------------
% effects 
%-------------------------------------------------------------------------------

%initiates(increment, value, ( (1,1), (1, (value, S)) ), S) :- step(S).
&sum{one} = 1.  % TODO workaround for lpx
initiates(increment, value, ( (1,one), (1, (value, S)) ), S) :- step(S).

%initiates(reset, value, ( (0,0) ), S) :- step(S).
% TODO workaround for lpx
initiates(reset, value, ( (0, (value, S)) ), S) :- step(S).


%-------------------------------------------------------------------------------
% observations
%-------------------------------------------------------------------------------

initiallyP(value, 0).
:- releasedAt(F,0), fluent(F).  % nothing is initially released from inertia
:- releasedAt(F,0), ffluent(F). % nothing is initially released from inertia


%-------------------------------------------------------------------------------
% narrative 
%-------------------------------------------------------------------------------

obs(happens, increment,   10).
obs(happens, increment,   20).
obs(happens, reset,       30).
obs(happens, increment,   40).
