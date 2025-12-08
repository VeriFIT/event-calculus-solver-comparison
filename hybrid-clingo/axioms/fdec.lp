% log of changes to get FDEC from DEC:
%   renamed maxtime to maxstep
%   renamed fluent to dfluent
%   TODO maybe should also rename "time" to "timeStep" or "dtime"?
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
initiates(E,F,T) :- initiates(E,F,EQ,T).
fluent(F) :- dfluent(F).  %   discrete fluents are fluents
fluent(F) :- ffluent(F).  % functional fluents are fluents


%-------------------------------------------------------------------------------
% DEC axioms -- slightly modified (changed fluent to dfluent in many rules, 
%               renamed maxtime to maxstep)
%-------------------------------------------------------------------------------

time(0..maxstep).
{holdsAt(F,T)} :- dfluent(F), time(T).                            %? dfluent
{releasedAt(F,T)} :- fluent(F), time(T).                          %! fluent

% DEC1
stoppedIn(T1,F,T2) :- happens(E,T), T1<T, T<T2,
  terminates(E,F,T), event(E), dfluent(F), time(T),               %? dfluent
  time(T1), time(T2).

% DEC2
startedIn(T1,F,T2) :- happens(E,T), T1<T, T<T2,
  initiates(E,F,T), event(E), dfluent(F), time(T),                %? dfluent
  time(T1), time(T2).

% DEC3
holdsAt(F2,T2) :- happens(E,T1), initiates(E,F1,T1), T1<T2,
  trajectory(F1,T1,F2,T2), not stoppedIn(T1,F1,T2),
  event(E), dfluent(F1), dfluent(F2), time(T1), time(T2).         %? dfluent
  %T1+T2<maxstep.  % TODO

% DEC4
holdsAt(F2,T1+T2) :- happens(E,T1), terminates(E,F1,T1), 0<T2,
  antiTrajectory(F1,T1,F2,T2), not startedIn(T1,F1,T1+T2),
  event(E), dfluent(F1), dfluent(F2), time(T1), time(T2),         %? dfluent
  T1+T2<maxstep.

initiated1(F,T) :- happens(E,T), initiates(E,F,T), event(E),
  fluent(F), time(T).                                             %! fluent
terminated1(F,T) :- happens(E,T), terminates(E,F,T), event(E),
  dfluent(F), time(T).                                            %? dfluent
released1(F,T) :- happens(E,T), releases(E,F,T), event(E),
  fluent(F), time(T).                                             %! fluent

% DEC5
holdsAt(F,T+1) :- holdsAt(F,T), not releasedAt(F,T+1),
  not terminated1(F,T), dfluent(F), time(T), T<maxstep.           %? dfluent

% DEC6
:- holdsAt(F,T+1), not holdsAt(F,T), not releasedAt(F,T+1),
  not initiated1(F,T), dfluent(F), time(T), T<maxstep.            %? dfluent

% DEC7
releasedAt(F,T+1) :- releasedAt(F,T), not initiated1(F,T),
  not terminated1(F,T), fluent(F), time(T), T<maxstep.            %! fluent

% DEC8
:- releasedAt(F,T+1), not releasedAt(F,T), not released1(F,T),
  fluent(F), time(T), T<maxstep.                                  %! fluent

% DEC9
holdsAt(F,T+1) :- happens(E,T), initiates(E,F,T), event(E),
  dfluent(F), time(T), T<maxstep.                                 %? dfluent

% DEC10
:- holdsAt(F,T+1), happens(E,T), terminates(E,F,T), event(E),
  dfluent(F), time(T), T<maxstep.                                 %? dfluent

% DEC11
releasedAt(F,T+1) :- happens(E,T), releases(E,F,T), event(E),
  fluent(F), time(T), T<maxstep.

% DEC12
:- releasedAt(F,T+1), happens(E,T), initiates(E,F,T),
  event(E), fluent(F), time(T), T<maxstep.                        %! fluent
:- releasedAt(F,T+1), happens(E,T), terminates(E,F,T),
  event(E), dfluent(F), time(T), T<maxstep.                       %? dfluent


%-------------------------------------------------------------------------------
% 4 new FDEC axioms
%-------------------------------------------------------------------------------

% FDEC13 (corresponds to DEC3)
&sum{ A1*A2; B*fholdsAt(F0,T1); INC*(ftimeAtStep(T2) - ftimeAtStep(T1)) } = fholdsAt(F2,T2) :-
  happens(E,T1), initiates(E,F1,T1), T1<T2,
  trajectory(F1,T1,F2,(A1,A2,B,F0,INC),T2),
  not stoppedIn(T1,F1,T2),
  event(E), dfluent(F1), ffluent(F2), time(T1), time(T2).
  %T1+T2<maxstep.  % TODO

% FDEC14 (corresponds to DEC4)
&sum{ A1*A2; B*fholdsAt(F0,T1); INC*(ftimeAtStep(T2) - ftimeAtStep(T1)) } = fholdsAt(F2,T2) :-
  happens(E,T1), terminates(E,F1,T1), T1<T2,
  antiTrajectory(F1,T1,F2,(A1,A2,B,F0,INC),T2),
  not startedIn(T1,F1,T2),
  event(E), dfluent(F1), ffluent(F2), time(T1), time(T2).
  %T1+T2<maxstep.  % TODO

% FDEC15 (corresponds to DEC5)
% note OV: no holdsAt and initiated instead of terminated
&sum{ fholdsAt(F,T) } = fholdsAt(F,T+1) :- not releasedAt(F,T+1),
  not initiated1(F,T), ffluent(F), time(T), T<maxstep.

% FDEC16 (corresponds to DEC9)
&sum{ A1*A2; B*fholdsAt(F0,T) } = fholdsAt(F,T+1) :-
  happens(E,T), initiates(E,F,(A1,A2,B,F0),T), event(E),
  ffluent(F), time(T), T<maxstep.


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

% time(S): S is a time step, ranges from 0 to maxstep
time(0..maxstep).

% ftimeAtStep(S): the time of step S
&sum{ ftimeAtStep(0) } = 0.                                     % step 0 is at time 0
&sum{ ftimeAtStep(S) } > ftimeAtStep(S-1) :- S > 0, time(S).    % consecutive steps must have greater time                            

% map(GT, S): Map ground time point GT to time step S                                                                                      
  map(0, 0).                                                              % step 0 maps to time 0
{ map(GT, S) : time(S) } = 1 :- in_happens(_, GT), GT > 0, GT < maxtime.  % steps map to occurrence times of input events (facts from the narrative)
  map(maxtime, maxstep) :- not disable_laststep.                          % maxstep maps to maxtime (unless disabled)

% if GT is mapped to S, then S is at time GT                                                                                     
&sum{ ftimeAtStep(S) } = GT :- map(GT, S), time(S).                                                                                              

% mapping "happens at time" to "happens at step"
happens(E, S) :- in_happens(E, GT), map(GT, S).                            

% func. atom that represents the time difference between each pair of timepoints
&sum{ftimeAtStep(T2) - ftimeAtStep(T1)} = timeDiff(T1, T2) :- time(T1), time(T2), T1 < T2.
&sum{0} = timeDiff(T, T) :- time(T).

% TODO this constraint should not be strictly necessary, but disabling it leads to problems with bugs in clingo-lpx and makes things more complicated
% restrict free floating steps to avoid seeing useless steps:
:- time(S), not significant_step(S),                % all steps must be significant
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
comparison(fholdsAt(F,T), Val) :- trigger_value(F, Val), time(T).
:- trigger_value(F, Val), normal_atom(fholdsAt(F, T), gt, Val), normal_atom(fholdsAt(F, T+1), lt, Val), time(T), time(T+1).
:- trigger_value(F, Val), normal_atom(fholdsAt(F, T), lt, Val), normal_atom(fholdsAt(F, T+1), gt, Val), time(T), time(T+1).
comparison(fholdsAt(F,T), Val) :- trigger_value(F, _, Val), time(T).
:- trigger_value(F, CF, Val), holdsAt(CF, T+1), normal_atom(fholdsAt(F, T), gt, Val), normal_atom(fholdsAt(F, T+1), lt, Val), time(T), time(T+1).
:- trigger_value(F, CF, Val), holdsAt(CF, T+1), normal_atom(fholdsAt(F, T), lt, Val), normal_atom(fholdsAt(F, T+1), gt, Val), time(T), time(T+1).
% same for timepoints 
comparison(ftimeAtStep(T), TriggT) :- trigger_time(TriggT), time(T).
%:- trigger_time(TriggT), normal_atom(ftimeAtStep(T), gt, TriggT), normal_atom(ftimeAtStep(T+1), lt, TriggT), time(T), time(T+1). % TODO time never goes backwards
:- trigger_time(TriggT), normal_atom(ftimeAtStep(T), lt, TriggT), normal_atom(ftimeAtStep(T+1), gt, TriggT), time(T), time(T+1).


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
% TODO rename fholdsAt?
% TODO rename ftimeAtStep?

% below was added to make these axioms compatible with the BEC/DBEC examples without a need to modify the examples
:- releasedAt(F,0), fluent(F).              % nothing is initially released from CLoI
:- holdsAt(F, 0), initiallyN(F), dfluent(F).
holdsAt(F, 0) :- initiallyP(F), dfluent(F).
&sum{ fholdsAt(F,0) } = V :- initiallyP(F, V), ffluent(F).
