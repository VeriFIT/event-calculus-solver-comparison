% log of changes to get FDEC from DEC:
%   renamed maxtime to maxstep
%   renamed fluent to dfluent
%   renamed time to step
%   then re-introduced "fluent" with rules fluent :- dfluent. fluent :- ffluent.
%   add initiates/3 :- initiates/4      (needed to reuse axioms for releasedAt)
%?  DEC 7,8,12 refer to fluent, initiated1/released1 refer to fluent
%   add FDEC 13-16
%   add normal_atom for comparing func. values -- TODO workaround due to lpx not allowing func. atoms in the body
%   add mapping of time to steps
% 
% overview of: ffluent vs dfluent vs fluent
%   DEC  1-4   -- dfluent   (trajectories)
%   DEC  5,6   -- dfluent   (inertia holdsAt)
%   DEC  7,8   -- fluent    (inertia releasedAt)
%   DEC  9,10  -- dfluent   (init/term holdsAt)
%   DEC  11,12 -- fluent    (init/term releasedAt)
%   FDEC 13-16 -- ffluent   (correspond to DEC 3,4,5,9)
%
%
% needed improvements:
%   removing normal_atom (by &sum{} in the body)
%
% possible extensions:
%   holdsAt for ffluents
%   trajectory controlled by a ffluent
%   functional events
%

%! added 3 rules -- only used in DEC12 and in initiated1/released1
initiates(E,F,S) :- initiates(E,F,EQ,S).
fluent(F) :- dfluent(F).  %   discrete fluents are fluents
fluent(F) :- ffluent(F).  % functional fluents are fluents


%-------------------------------------------------------------------------------
% DEC axioms -- slightly modified (changed fluent to dfluent in many rules, 
%               renamed maxtime to maxstep)
%-------------------------------------------------------------------------------

step(0..maxstep).
{   holdsAt(F,S)} :- dfluent(F), step(S).                         %? dfluent
{releasedAt(F,S)} :-  fluent(F), step(S).                         %! fluent

% DEC1
stoppedIn(S1,F,S2) :- happens(E,S), S1<S, S<S2,
  terminates(E,F,S), event(E), dfluent(F), step(S),               %? dfluent
  step(S1), step(S2).

% DEC2
startedIn(S1,F,S2) :- happens(E,S), S1<S, S<S2,
  initiates(E,F,S), event(E), dfluent(F), step(S),                %? dfluent
  step(S1), step(S2).

% DEC3
holdsAt(F2,S2) :- happens(E,S1), initiates(E,F1,S1), S1<S2,
  trajectory(F1,S1,F2,S2), not stoppedIn(S1,F1,S2),
  event(E), dfluent(F1), dfluent(F2), step(S1), step(S2).         %? dfluent
  %S1+S2<maxstep.  % TODO

% DEC4
holdsAt(F2,S1+S2) :- happens(E,S1), terminates(E,F1,S1), 0<S2,
  antiTrajectory(F1,S1,F2,S2), not startedIn(S1,F1,S1+S2),
  event(E), dfluent(F1), dfluent(F2), step(S1), step(S2),         %? dfluent
  S1+S2<maxstep.

initiated1(F,S) :- happens(E,S), initiates(E,F,S), event(E),
  fluent(F), step(S).                                             %! fluent
terminated1(F,S) :- happens(E,S), terminates(E,F,S), event(E),
  fluent(F), step(S).                                             %! fluent
released1(F,S) :- happens(E,S), releases(E,F,S), event(E),
  fluent(F), step(S).                                             %! fluent

% DEC5
holdsAt(F,S+1) :- holdsAt(F,S), not releasedAt(F,S+1),
  not terminated1(F,S), dfluent(F), step(S), S<maxstep.           %? dfluent

% DEC6
:- holdsAt(F,S+1), not holdsAt(F,S), not releasedAt(F,S+1),
  not initiated1(F,S), dfluent(F), step(S), S<maxstep.            %? dfluent

% DEC7
releasedAt(F,S+1) :- releasedAt(F,S), not initiated1(F,S),
  not terminated1(F,S), fluent(F), step(S), S<maxstep.            %! fluent

% DEC8
:- releasedAt(F,S+1), not releasedAt(F,S), not released1(F,S),
  fluent(F), step(S), S<maxstep.                                  %! fluent

% DEC9
holdsAt(F,S+1) :- happens(E,S), initiates(E,F,S), event(E),
  dfluent(F), step(S), S<maxstep.                                 %? dfluent

% DEC10
:- holdsAt(F,S+1), happens(E,S), terminates(E,F,S), event(E),
  dfluent(F), step(S), S<maxstep.                                 %? dfluent

% DEC11
releasedAt(F,S+1) :- happens(E,S), releases(E,F,S), event(E),
  fluent(F), step(S), S<maxstep.

% DEC12
:- releasedAt(F,S+1), happens(E,S), initiates(E,F,S),
  event(E), fluent(F), step(S), S<maxstep.                        %! fluent
:- releasedAt(F,S+1), happens(E,S), terminates(E,F,S),
  event(E), fluent(F), step(S), S<maxstep.                        %! fluent


%-------------------------------------------------------------------------------
% 4 new FDEC axioms
%-------------------------------------------------------------------------------

% FDEC13 (corresponds to DEC3)
&sum{ A1*A2; B*(F0,S1); INC*(time(S2) - time(S1)) } = (F2,S2) :-
  happens(E,S1), initiates(E,F1,S1), S1<S2,
  trajectory(F1,S1,F2,(A1,A2,B,F0,INC),S2),
  not stoppedIn(S1,F1,S2),
  event(E), dfluent(F1), ffluent(F2), step(S1), step(S2).
  %S1+S2<maxstep.  % TODO

% FDEC14 (corresponds to DEC4)
&sum{ A1*A2; B*(F0,S1); INC*(time(S2) - time(S1)) } = (F2,S2) :-
  happens(E,S1), terminates(E,F1,S1), S1<S2,
  antiTrajectory(F1,S1,F2,(A1,A2,B,F0,INC),S2),
  not startedIn(S1,F1,S2),
  event(E), dfluent(F1), ffluent(F2), step(S1), step(S2).
  %S1+S2<maxstep.  % TODO

% FDEC15 (corresponds to DEC5)
% note OV: no holdsAt and initiated instead of terminated
&sum{ (F,S) } = (F,S+1) :- not releasedAt(F,S+1),
  not initiated1(F,S), ffluent(F), step(S), S<maxstep.

% FDEC16 (corresponds to DEC9)
&sum{ A1*A2; B*(F0,S) } = (F,S+1) :-
  happens(E,S), initiates(E,F,(A1,A2,B,F0),S), event(E),
  ffluent(F), step(S), S<maxstep.


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
&sum{ time(0) } = 0.                              % step 0 is at time 0
&sum{ time(S) } > time(S-1) :- S > 0, step(S).    % consecutive steps must have greater time

% map(T, S): Map ground time point T to time step S
  map(0, 0).                                                                % step 0 maps to time 0
  map(maxtime, maxstep) :- not disable_laststep.                            % maxstep maps to maxtime (unless disabled)
{ map(T, S) : step(S) } = 1 :- in_happens(_, T), T > 0, T < maxtime.        % steps map to occurrence times of input events (facts from the narrative)
{ map(T, S) : step(S) } = 1 :- in_holdsAt(_, T), T > 0, T < maxtime.        % steps map to times of input observations (facts from the narrative)
{ map(T, S) : step(S) } = 1 :- in_releasedAt(_, T), T > 0, T < maxtime.     % steps map to times of input observations (facts from the narrative)
{ map(T, S) : step(S) } = 1 :- in_not_holdsAt(_, T), T > 0, T < maxtime.    % steps map to times of negative input observations (facts from the narrative)
{ map(T, S) : step(S) } = 1 :- in_not_releasedAt(_, T), T > 0, T < maxtime. % steps map to times of negative input observations (facts from the narrative)
{ map(T, S) : step(S) } = 1 :- in_fvalue(_, _, T), T > 0, T < maxtime.      % steps map to times of input observations for ffluents (facts from the narrative)

% if T is mapped to S, then S is at time T
&sum{ time(S) } = T :- map(T, S), step(S).

% mapping "happens at time" to "happens at step"
happens(E, S) :- in_happens(E, T), map(T, S).
% mapping "holdsAt time" to "holdsAt step"
holdsAt(F, S) :- in_holdsAt(F, T), map(T, S).
checkStep(S) :- in_holdsAt(F, T), map(T, S).    % in case there is no event at that step
% mapping "releasedAt time" to "releasedAt step"
releasedAt(F, S) :- in_releasedAt(F, T), map(T, S).
checkStep(S) :- in_releasedAt(F, T), map(T, S).    % in case there is no event at that step
% mapping "not_holdsAt time" to "not holdsAt step"
:- holdsAt(F, S), in_not_holdsAt(F, T), map(T, S).
checkStep(S) :- in_not_holdsAt(F, T), map(T, S).    % in case there is no event at that step
% mapping "not_releasedAt time" to "not releasedAt step"
:- releasedAt(F, S), in_not_releasedAt(F, T), map(T, S).
checkStep(S) :- in_not_releasedAt(F, T), map(T, S).    % in case there is no event at that step
% mapping "fvalue at time" to "holdsAt step"
&sum{ (F,S) } = V :- in_fvalue(F, V, T), map(T, S).
checkStep(S) :- in_fvalue(F, _, T), map(T, S).    % in case there is no event at that step

% func. atom that represents the time difference between each pair of timepoints
&sum{time(S2) - time(S1)} = timeDiff(S1, S2) :- step(S1), step(S2), S1 < S2.
&sum{0} = timeDiff(S, S) :- step(S).

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

% designating significant values of continuous fluents so that we do not miss them during trajectories
comparison((F,S), Val) :- trigger_value(F, Val), step(S).
:- trigger_value(F, Val), normal_atom((F, S), gt, Val), normal_atom((F, S+1), lt, Val), step(S), step(S+1).
:- trigger_value(F, Val), normal_atom((F, S), lt, Val), normal_atom((F, S+1), gt, Val), step(S), step(S+1).
comparison((F,S), Val) :- trigger_value(F, _, Val), step(S).
:- trigger_value(F, CF, Val), holdsAt(CF, S+1), normal_atom((F, S), gt, Val), normal_atom((F, S+1), lt, Val), step(S), step(S+1).
:- trigger_value(F, CF, Val), holdsAt(CF, S+1), normal_atom((F, S), lt, Val), normal_atom((F, S+1), gt, Val), step(S), step(S+1).
% same for timepoints 
comparison(time(S), TriggT) :- trigger_time(TriggT), step(S).
%:- trigger_time(TriggT), normal_atom(time(S), gt, TriggT), normal_atom(time(S+1), lt, TriggT), step(S), step(S+1). % TODO time never goes backwards
:- trigger_time(TriggT), normal_atom(time(S), lt, TriggT), normal_atom(time(S+1), gt, TriggT), step(S), step(S+1).
% also make it a checkstep in case trigger_time is used to mark a holdsAt (not an event trigger)
checkStep(T) :- trigger_time(TriggT), normal_atom(time(T), eq, TriggT).


%-------------------------------------------------------------------------------
% Defined
%-------------------------------------------------------------------------------

% define #const maxstep
% define #const maxtime

#defined in_happens/2.
#defined in_holdsAt/2.
#defined in_releasedAt/2.
#defined in_not_holdsAt/2.
#defined in_not_releasedAt/2.
#defined in_fvalue/3.

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

% below was added to make these axioms compatible with the BEC/DBEC examples without a need to modify the examples
%%% :- releasedAt(F,0), fluent(F).              % nothing is initially released from CLoI
:- holdsAt(F, 0), initiallyN(F), dfluent(F).
holdsAt(F, 0) :- initiallyP(F), dfluent(F).
&sum{ (F,0) } = V :- initiallyP(F, V), ffluent(F).
