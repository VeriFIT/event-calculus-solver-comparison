% JR: the encoding accepts only simple linear equations
%     with a fixed small number of arguments, 
%     this can be made more general

% JR: added 3 rules
initiates(E,F,T) :- initiates(E,F,EQ,T).
fluent(F) :- dfluent(F). %   discrete fluents are fluents
fluent(F) :- ffluent(F). % functional fluents are fluents

time(0..maxtime).
{holdsAt(F,T)} :- dfluent(F), time(T). % JR: replaced fluent by dfluent 
{releasedAt(F,T)} :- fluent(F), time(T).

% JR: normal rule heads of predicates holdsAt/2 or releasedAt/2 
%     can be shifted to the body

% JR: for ffluents there is no terminates

% DEC1
stoppedIn(T1,F,T2) :- happens(E,T), T1<T, T<T2,
  terminates(E,F,T), event(E), fluent(F), time(T),
  time(T1), time(T2).

% DEC2
startedIn(T1,F,T2) :- happens(E,T), T1<T, T<T2,
  initiates(E,F,T), event(E), fluent(F), time(T),
  time(T1), time(T2).

% JR: add trajectories where F1 is boolean and F2 is functional

% DEC3
holdsAt(F2,T1+T2) :- happens(E,T1), initiates(E,F1,T1), 0<T2,
  trajectory(F1,T1,F2,T2), not stoppedIn(T1,F1,T1+T2),
  event(E), fluent(F1), fluent(F2), time(T1), time(T2),
  T1+T2<maxtime.

% JR: added
&sum{ A; B*(F,T1); INC*t(T2) } = (F2,T1+T2) :-
  happens(E,T1), initiates(E,F1,T1), 0<T2,
  trajectory(F1,T1,F2,(A,B,F,INC),T2),
  not stoppedIn(T1,F1,T1+T2),
  event(E), dfluent(F1), ffluent(F2), time(T1), time(T2),
  T1+T2<maxtime.

% DEC4
holdsAt(F2,T1+T2) :- happens(E,T1), terminates(E,F1,T1), 0<T2,
  antiTrajectory(F1,T1,F2,T2), not startedIn(T1,F1,T1+T2),
  event(E), fluent(F1), fluent(F2), time(T1), time(T2),
  T1+T2<maxtime.

% JR: added
&sum{ A; B*(F,T1); INC*t(T2) } = (F2,T1+T2) :-
  happens(E,T1), terminates(E,F1,T1), 0<T2,
  antitrajectory(F1,T1,F2,(A,B,F,INC),T2),
  not startedIn(T1,F1,T1+T2),
  event(E), dfluent(F1), ffluent(F2), time(T1), time(T2),
  T1+T2<maxtime.

initiated1(F,T) :- happens(E,T), initiates(E,F,T), event(E),
  fluent(F), time(T).
terminated1(F,T) :- happens(E,T), terminates(E,F,T), event(E),
  fluent(F), time(T).
released1(F,T) :- happens(E,T), releases(E,F,T), event(E),
  fluent(F), time(T).

% DEC5
holdsAt(F,T+1) :- holdsAt(F,T), not releasedAt(F,T+1),
  not terminated1(F,T), fluent(F), time(T), T<maxtime.

% JR: added for ffluents
&sum { (F,T) } = (F,T+1) :- not releasedAt(F,T+1),
  not initiated1(F,T), ffluent(F), time(T), T<maxtime.

% DEC6
:- holdsAt(F,T+1), not holdsAt(F,T), not releasedAt(F,T+1),
  not initiated1(F,T), fluent(F), time(T), T<maxtime.

% DEC7
releasedAt(F,T+1) :- releasedAt(F,T), not initiated1(F,T),
  not terminated1(F,T), fluent(F), time(T), T<maxtime.

% DEC8
:- releasedAt(F,T+1), not releasedAt(F,T), not released1(F,T),
  fluent(F), time(T), T<maxtime.

% DEC9
% JR: replaced fluent by dfluent
holdsAt(F,T+1) :- happens(E,T), initiates(E,F,T), event(E),
  dfluent(F), time(T), T<maxtime.

% JR: added for ffluents
&sum{ A; B*(F,T) } = (F1,T+1) :-
   happens(E,T), initiates(E,F,(A,B,F),T), event(E),
   ffluent(F), time(T), T<maxtime.

% DEC10
:- holdsAt(F,T+1), happens(E,T), terminates(E,F,T), event(E),
  fluent(F), time(T), T<maxtime.

% DEC11
releasedAt(F,T+1) :- happens(E,T), releases(E,F,T), event(E),
  fluent(F), time(T), T<maxtime.

% DEC12
:- releasedAt(F,T+1), happens(E,T), initiates(E,F,T),
  event(E), fluent(F), time(T), T<maxtime.
:- releasedAt(F,T+1), happens(E,T), terminates(E,F,T),
  event(E), fluent(F), time(T), T<maxtime.
