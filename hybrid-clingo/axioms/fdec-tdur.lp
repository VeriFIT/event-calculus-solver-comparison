% version of fdec.lp that preserves the original formulation of the trajectory predicate
%   fdec.lp uses trajectory(F1,T1,F2,T2) where both T1 and T2 are steps/timepoints [--> holdsAt(F2,T2)]
%   in this version T2 represents the duration of the trajectory [--> holdsAt(F2,T1+T2)]
% however, this is a bit more complicated since T2 as duration is a functional/non-ground atom

%! added 3 rules -- only used in DEC12 and in initiated1/released1
initiates(E,F,T) :- initiates(E,F,EQ,T).
fluent(F) :- dfluent(F).  %   discrete fluents are fluents
fluent(F) :- ffluent(F).  % functional fluents are fluents


%-------------------------------------------------------------------------------
% DEC axioms -- slightly modified (changed fluent to dfluent in many rules, 
%               renamed maxtime to maxstep)
%-------------------------------------------------------------------------------

step(0..maxstep).
{holdsAt(F,T)} :- dfluent(F), step(T).                            %? dfluent
{releasedAt(F,T)} :- fluent(F), step(T).                          %! fluent

% DEC1
stoppedIn(T1,F,T2) :- happens(E,T), T1<T, T<T2,
  terminates(E,F,T), event(E), dfluent(F), step(T),               %? dfluent
  step(T1), step(T2).

% DEC2
startedIn(T1,F,T2) :- happens(E,T), T1<T, T<T2,
  initiates(E,F,T), event(E), dfluent(F), step(T),                %? dfluent
  step(T1), step(T2).

% DEC3
holdsAt(F2,T2) :- happens(E,T1), initiates(E,F1,T1), T1<T2,
  trajectory(F1,T1,F2,timeDiff(T1, T2)), not stoppedIn(T1,F1,T2),
  event(E), dfluent(F1), dfluent(F2), step(T1), step(T2).         %? dfluent
  %T1+T2<maxstep.  % TODO

% DEC4
holdsAt(F2,T1+T2) :- happens(E,T1), terminates(E,F1,T1), 0<T2,
  antiTrajectory(F1,T1,F2,T2), not startedIn(T1,F1,T1+T2),
  event(E), dfluent(F1), dfluent(F2), step(T1), step(T2),         %? dfluent
  T1+T2<maxstep.

initiated1(F,T) :- happens(E,T), initiates(E,F,T), event(E),
  fluent(F), step(T).                                             %! fluent
terminated1(F,T) :- happens(E,T), terminates(E,F,T), event(E),
  dfluent(F), step(T).                                            %? dfluent
released1(F,T) :- happens(E,T), releases(E,F,T), event(E),
  fluent(F), step(T).                                             %! fluent

% DEC5
holdsAt(F,T+1) :- holdsAt(F,T), not releasedAt(F,T+1),
  not terminated1(F,T), dfluent(F), step(T), T<maxstep.           %? dfluent

% DEC6
:- holdsAt(F,T+1), not holdsAt(F,T), not releasedAt(F,T+1),
  not initiated1(F,T), dfluent(F), step(T), T<maxstep.            %? dfluent

% DEC7
releasedAt(F,T+1) :- releasedAt(F,T), not initiated1(F,T),
  not terminated1(F,T), fluent(F), step(T), T<maxstep.            %! fluent

% DEC8
:- releasedAt(F,T+1), not releasedAt(F,T), not released1(F,T),
  fluent(F), step(T), T<maxstep.                                  %! fluent

% DEC9
holdsAt(F,T+1) :- happens(E,T), initiates(E,F,T), event(E),
  dfluent(F), step(T), T<maxstep.                                 %? dfluent

% DEC10
:- holdsAt(F,T+1), happens(E,T), terminates(E,F,T), event(E),
  dfluent(F), step(T), T<maxstep.                                 %? dfluent

% DEC11
releasedAt(F,T+1) :- happens(E,T), releases(E,F,T), event(E),
  fluent(F), step(T), T<maxstep.

% DEC12
:- releasedAt(F,T+1), happens(E,T), initiates(E,F,T),
  event(E), fluent(F), step(T), T<maxstep.                        %! fluent
:- releasedAt(F,T+1), happens(E,T), terminates(E,F,T),
  event(E), dfluent(F), step(T), T<maxstep.                       %? dfluent


%-------------------------------------------------------------------------------
% 4 new FDEC axioms
%-------------------------------------------------------------------------------

% FDEC13 (corresponds to DEC3)
% TODO using T2 as duration: cant say T1+T2 (that is discrete step + func. time)
% TODO would need to say T2 such that step(T2) is "step(T1) + duration"
% &sum{ A1*A2; B*(F,T1); INC*T2 } = (F2,T1+T2) :-
%   happens(E,T1), initiates(E,F1,T1), 0<T2,
%   trajectory(F1,T1,F2,(A1,A2,B,F,INC),T2),
%   not stoppedIn(T1,F1,T1+T2),
%   event(E), dfluent(F1), ffluent(F2), step(T1), step(T2).
%   %T1+T2<maxstep.  % TODO

% could use something like this, but this would need the "T1+T2" in timeDiff evaluated into an auxiliary atom or would need timeDiff/3 or something like that 
%&sum{ A1*A2; B*(F,T1); INC*timeDiff(T1, T1+T2)} = (F2,T1+T2) :-
%  happens(E,T1), initiates(E,F1,T1), 0<T2,
%  trajectory(F1,T1,F2,(A1,A2,B,F,INC),T2),
%  not stoppedIn(T1,F1,T1+T2),
%  event(E), dfluent(F1), ffluent(F2), step(T1), step(T2).
%  %T1+T2<maxstep.  % TODO

% or can replace "duration in steps" with "functional duration" using timeDiff/2
&sum{ A1*A2; B*(F0,T1); INC*timeDiff(T1, T2)} = (F2,T2) :-
  happens(E,T1), initiates(E,F1,T1), T1<T2,
  trajectory(F1,T1,F2,(A1,A2,B,F0,INC), timeDiff(T1, T2)),
  not stoppedIn(T1,F1,T2),
  event(E), dfluent(F1), ffluent(F2), step(T1), step(T2).
  %T1+T2<maxstep.  % TODO


%% % TODO this would need trajectory predicate changed in a similar way as DEC inertia (referring to T and T+1 instead of T1 and T2)
%% &sum{time(T+1) - time(T)} = timeDiff(T, T+1) :- step(T+1), step(T).
%% % first step of a trajectory
%% &sum{ A1*A2; B*(F0,T); INC*timeDiff(T, T+1)} = (F2,T+1) :-
%%   happens(E,T), initiates(E,F1,T),
%%   trajectory(F1,T,F2,(A1,A2,B,F0,INC), T+1),
%%   event(E), dfluent(F1), ffluent(F2), step(T), step(T+1).
%% % inertia of a trajectory
%% &sum{ (F2,T); INC*timeDiff(T, T+1)} = (F2,T+1) :-
%%   holdsAt(F1, T),
%%   trajectory(F1,_,F2,(_,_,_,_,INC),T+1),
%%   not releasedAt(F1,T+1), not terminated1(F1,T),
%%   event(E), dfluent(F1), ffluent(F2), step(T), step(T+1).


% FDEC14 (corresponds to DEC4)
&sum{ A1*A2; B*(F,T1); INC*(time(T2) - time(T1)) } = (F2,T2) :-
  happens(E,T1), terminates(E,F1,T1), T1<T2,
  antiTrajectory(F1,T1,F2,(A1,A2,B,F,INC),T2),
  not startedIn(T1,F1,T2),
  event(E), dfluent(F1), ffluent(F2), step(T1), step(T2).
  %T1+T2<maxstep.  % TODO

% FDEC15 (corresponds to DEC5)
% note OV: no holdsAt and initiated instead of terminated
&sum{ (F,T) } = (F,T+1) :- not releasedAt(F,T+1),
  not initiated1(F,T), ffluent(F), step(T), T<maxstep.

% FDEC16 (corresponds to DEC9)
&sum{ A1*A2; B*(F0,T) } = (F,T+1) :-
  happens(E,T), initiates(E,F,(A1,A2,B,F0),T), event(E),
  ffluent(F), step(T), T<maxstep.


%-------------------------------------------------------------------------------
% comparing functional values
%-------------------------------------------------------------------------------

% TODO needed only because clingo-lpx does not allow &sum in the body of rules

% predicates for comparing values of functional fluents
% theory_atom(A,COMPARISON,B)
{ normal_atom(A, (lt;eq;gt), B) } = 1 :- comparison(A, B).
%
&sum{ A } < B :- normal_atom(A, lt, B).
&sum{ A } = B :- normal_atom(A, eq, B).
&sum{ A } > B :- normal_atom(A, gt, B).
%
normal_atom(A, leq, B) :- normal_atom(A, lt, B).
normal_atom(A, leq, B) :- normal_atom(A, eq, B).
normal_atom(A, geq, B) :- normal_atom(A, eq, B).
normal_atom(A, geq, B) :- normal_atom(A, gt, B).

% adhoc version to allow "A1 + A1, COMPARISON, B"
{ normal_atom(A1, A2, (lt;eq;gt), B) } = 1 :- comparison(A1, A2, B).
%
&sum{ A1 + A2 } < B :- normal_atom(A1, A2, lt, B).
&sum{ A1 + A2 } = B :- normal_atom(A1, A2, eq, B).
&sum{ A1 + A2 } > B :- normal_atom(A1, A2, gt, B).
%
normal_atom(A1, A2, leq, B) :- normal_atom(A1, A2, lt, B).
normal_atom(A1, A2, leq, B) :- normal_atom(A1, A2, eq, B).
normal_atom(A1, A2, geq, B) :- normal_atom(A1, A2, eq, B).
normal_atom(A1, A2, geq, B) :- normal_atom(A1, A2, gt, B).


%-------------------------------------------------------------------------------
% mapping time to steps
%-------------------------------------------------------------------------------

% step(S): S is a time step, ranges from 0 to maxstep
step(0..maxstep).

% time(S): the time of step S
&sum{ time(0) } = 0.                                     % step 0 is at time 0
&sum{ time(S) } > time(S-1) :- S > 0, step(S).    % consecutive steps must have greater time

% map(GT, S): Map ground time point GT to time step S
  map(0, 0).                                                              % step 0 maps to time 0
{ map(GT, S) : step(S) } = 1 :- in_happens(_, GT), GT > 0, GT < maxtime.  % steps map to occurrence times of input events (facts from the narrative)
  map(maxtime, maxstep) :- not disable_laststep.                          % maxstep maps to maxtime (unless disabled)

% if GT is mapped to S, then S is at time GT
&sum{ time(S) } = GT :- map(GT, S), step(S).

% mapping "happens at time" to "happens at step"
happens(E, S) :- in_happens(E, GT), map(GT, S).

% func. atom that represents the time difference between each pair of timepoints
&sum{time(T2) - time(T1)} = timeDiff(T1, T2) :- step(T1), step(T2), T1 < T2.
&sum{0} = timeDiff(T, T) :- step(T).

% TODO this constraint should not be strictly necessary, but disabling it leads to problems with bugs in clingo-lpx and makes things more complicated
% restrict free floating steps to avoid seeing useless steps:
:- step(S), not significant_step(S),                % all steps must be significant
    not disable_significant_constr.                 % unless this constraint is disabled
significant_step(0).                                % step zero is significant
significant_step(maxstep) :- not disable_laststep.  % last step is significant (unless last step is disabled)
significant_step(S) :- happens(E, S).               % step is significant if an event happens
significant_step(S) :- checkStep(S).                % step is significant if its a checkStep % TODO up to debate, can just insert dummy events instead


%-------------------------------------------------------------------------------
% helper predicates to make domain description easier/shorter
%-------------------------------------------------------------------------------

% TODO needs a deeper thought about which is best (holdsAt T, or T+1, or both, or none, ...)
% designating significant values of continuous fluents so that we do not miss them during trajectories
comparison((F,T), Val) :- trigger_value(F, Val), step(T).
:- trigger_value(F, Val), normal_atom((F, T), gt, Val), normal_atom((F, T+1), lt, Val), step(T), step(T+1).
:- trigger_value(F, Val), normal_atom((F, T), lt, Val), normal_atom((F, T+1), gt, Val), step(T), step(T+1).
comparison((F,T), Val) :- trigger_value(F, _, Val), step(T).
:- trigger_value(F, CF, Val), holdsAt(CF, T+1), normal_atom((F, T), gt, Val), normal_atom((F, T+1), lt, Val), step(T), step(T+1).
:- trigger_value(F, CF, Val), holdsAt(CF, T+1), normal_atom((F, T), lt, Val), normal_atom((F, T+1), gt, Val), step(T), step(T+1).
% same for timepoints 
comparison(time(T), TriggT) :- trigger_time(TriggT), step(T).
%:- trigger_time(TriggT), normal_atom(time(T), gt, TriggT), normal_atom(time(T+1), lt, TriggT), step(T), step(T+1). % TODO time never goes backwards
:- trigger_time(TriggT), normal_atom(time(T), lt, TriggT), normal_atom(time(T+1), gt, TriggT), step(T), step(T+1).


%-------------------------------------------------------------------------------
% Defined
%-------------------------------------------------------------------------------

% define #const maxstep
% define #const maxtime

#defined in_happens/2.

#defined time/1.

#defined initiallyP/1.
#defined initiallyN/1.
#defined initiallyP/2.

#defined dfluent/1.
#defined ffluent/1.
#defined fluent/1.

#defined initiates/3.
#defined terminates/3.
#defined releases/3.
#defined trajectory/4.
#defined antiTrajectory/4.

#defined initiates/4.
#defined trajectory/5.
#defined antiTrajectory/5.

#defined checkStep/1.

#defined comparison/2.
#defined comparison/3.

#defined trigger_value/2.
#defined trigger_value/3.
#defined trigger_time/1.



%-------------------------------------------------------------------------------
% configuration of the axioms
%-------------------------------------------------------------------------------

#const disablelaststep=0.
#defined disable_laststep/0.
disable_laststep :- disablelaststep = 1.

#const disablesignificantconstr=0.
#defined disable_significant_constr/0.
disable_significant_constr :- disablesignificantconstr = 1.

#const debugprints=0.
#defined debug_prints/0.
debug_prints :- debugprints = 1.

#const negprints=0.
#defined negated_prints/0.
negated_prints :- negprints = 1.



%-------------------------------------------------------------------------------
% TMP STUFF 
%-------------------------------------------------------------------------------

% TODO figure out initiates/4 EQ
% TODO rename ?
% TODO rename ftimeAtStep?

% below was added to make these axioms compatible with the BEC/DBEC examples without a need to modify the examples
:- releasedAt(F,0), fluent(F).              % nothing is initially released from CLoI
:- holdsAt(F, 0), initiallyN(F), dfluent(F).
holdsAt(F, 0) :- initiallyP(F), dfluent(F).
&sum{ (F,0) } = V :- initiallyP(F, V), ffluent(F).
