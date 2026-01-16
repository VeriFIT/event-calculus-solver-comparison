% version of FDEC for happens3 -- events with duration

% OV: the if tries to handle the special case of ( (X) ) being converted to (X), e.g. ( (time, 0) )
#script (python)
import clingo
def member(t):
    if t.arguments[0].type == clingo.SymbolType.Function:
        return t.arguments
    else:
        return clingo.Function("", t.arguments, True)
#end.

% % JR: member() takes two arguments
% #script (python)
% def member(_,t):
%   return t.arguments 
% #end.

%-------------------------------------------------------------------------------
% DEC axioms -- slightly modified (changed fluent to dfluent in many rules, 
%               renamed maxtime to maxstep)
%-------------------------------------------------------------------------------

step(0..maxstep).
{    holdsAt(F,S) } :- fluent(F), step(S).
{ releasedAt(F,S) } :- fluent(F), step(S).

% DEC1
stoppedIn(S1,F,S4) :-
  S1<S3, S2<S4,
  happens3(E,S2,S3),
  terminates(E,F,S2),
  step(S1), step(S4).

% DEC2
startedIn(S1,F,S4) :-
  S1<S3, S2<S4,
  happens3(E,S2,S3),
  initiates(E,F,S2),
  step(S1), step(S4).

% DEC3
holdsAt(F2,S2+S3) :-
  happens3(E,S1,S2),
  initiates(E,F1,S1),
  0<S3,
  trajectory(F1,S1,F2,S3),
  not stoppedIn(S1,F1,S2+S3),
  step(S2+S3).

% DEC4
holdsAt(F2,S2+S3) :-
  happens3(E,S1,S2),
  initiates(E,F1,S1),
  0<S3,
  antiTrajectory(F1,S1,F2,S3),
  not startedIn(S1,F1,S2+S3),
  step(S2+S3).

initiated1(F,S2) :- happens3(E,S1,S2), initiates(E,F,S1).
terminated1(F,S2) :- happens3(E,S1,S2), terminates(E,F,S1).
released1(F,S2) :- happens3(E,S1,S2), releases(E,F,S1).

% DEC5
holdsAt(F,S+1) :-
  holdsAt(F,S),
  not releasedAt(F,S+1),
  not terminated1(F,S),
  step(S+1).

% DEC6
:- holdsAt(F,S+1),
  not holdsAt(F,S),
  not releasedAt(F,S+1),
  not initiated1(F,S),
  step(S), step(S+1).

% DEC7
releasedAt(F,S+1) :-
  releasedAt(F,S),
  not initiated1(F,S),
  not terminated1(F,S),
  step(S+1).

% DEC8
:- releasedAt(F,S+1),
  not releasedAt(F,S),
  not released1(F,S),
  step(S), step(S+1).

% DEC9
holdsAt(F,S2+1) :-
  happens3(E,S1,S2),
  initiates(E,F,S1),
  step(S2+1).

% DEC10
:- holdsAt(F,S2+1),
  happens3(E,S1,S2),
  terminates(E,F,S1),
  step(S2+1).

% DEC11
releasedAt(F,S2+1) :-
  happens3(E,S1,S2),
  releases(E,F,S1),
  step(S2+1).

% DEC12
:- releasedAt(F,S2+1),
  happens3(E,S1,S2),
  initiates(E,F,S1),
  step(S2+1).
:- releasedAt(F,S2+1),
  happens3(E,S1,S2),
  terminates(E,F,S1),
  step(S2+1).

% DEC 13
:- obs(happens3, E, T1, T2), T1 > T2.
:- happens3(E,S1,S2), S1 > S2.

% DEC 14
happens(E,S) :- happens3(E,S,S).

%-------------------------------------------------------------------------------
% FDEC
%-------------------------------------------------------------------------------

{releasedAt(F,S)} :- ffluent(F), step(S). 
% we do not need any choice for the value of variables in linear equations,
% since their value is open by default

% DEC1 only for discrete fluents

% FDEC1 (corresponds to DEC2)
% TODO OV: useful as utility
startedIn(S1,F,S4) :-
  S1<S3, S2<S4,
  happens3(E,S2,S3),
  initiates(E,F,_,S2),
  step(S1), step(S4).

% In the following rules:
%   LE stands for Linear Expression
%   C for Coefficient
%   V for (rational) Variable

% FDEC2 (corresponds to DEC3)
&sum{ C*V : @member(LE) = (C,V); CC*(time,S4); -CC*(time,S2); -(F2,S4) } = 0 :-
  S4=S2+S3,
  happens3(E,S1,S2),
  initiates(E,F1,S1),
  0<S3,
  trajectory(F1,S1,F2,(LE,CC),S3),
  not stoppedIn(S1,F1,S4),
  step(S4).

% FDEC3 (corresponds to DEC4)
&sum{ C*V : @member(LE) = (C,V); CC*(time,S4); -CC*(time,S2); -(F2,S4) } = 0 :-
  S4=S2+S3,
  happens3(E,S1,S2),
  terminates(E,F1,S1),
  0<S3,
  antiTrajectory(F1,S1,F2,(LE,CC),S3),
  not startedIn(S1,F1,S4),
  step(S4).

initiated1(F,S2) :- happens3(E,S1,S2), initiates(E,F,LE,S1).
% no terminated1(F,S) for ffluent(F)
%      released1(F,S) is defined above given releases(E,F,S) for ffluent(F)

% FDEC4 (corresponds to DEC5 and DEC6) 
% note OV: no holdsAt and initiated instead of terminated
&sum{ (F,S1); -(F,S2) } = 0 :-
  S2=S1+1,
  not releasedAt(F,S2), 
  not initiated1(F,S1),
  ffluent(F), step(S1), step(S2).

% DEC7 and DEC8 apply also to ffluent(F)

% FDEC5 (corresponds to DEC9 and DEC10)
&sum{ C*V : @member(LE) = (C,V); -(F,S3) } = 0 :-
  S3=S2+1,
  happens3(E,S1,S2),
  initiates(E,F,LE,S1),
  step(S2).

% DEC11 applies also to ffluent(F)

% FDEC6 (corresponds to DEC12)
:- releasedAt(F,S2+1),
  happens3(E,S1,S2),
  initiates(E,F,_,S1),
  step(S2+1).


%-------------------------------------------------------------------------------
% comparing functional values
%-------------------------------------------------------------------------------

% Note: needed only because clingo-lpx does not allow &sum in bodies

% comparison(LE,B): there is a comparison between linear equation LE and bound B
% sum(LE,lt/eq/gt,B): the sum of the members of LE is lt/eq/gt the bound B

{ sum(LE,(lt;eq;gt),B) } = 1 :- comparison(LE,B).
%
&sum{ C*V : @member(LE) = (C,V) } < B :- sum(LE,lt,B).
&sum{ C*V : @member(LE) = (C,V) } = B :- sum(LE,eq,B).
&sum{ C*V : @member(LE) = (C,V) } > B :- sum(LE,gt,B).
%
sum(LE,leq,B) :- sum(LE,lt,B).
sum(LE,leq,B) :- sum(LE,eq,B).
sum(LE,geq,B) :- sum(LE,eq,B).
sum(LE,geq,B) :- sum(LE,gt,B).


%-------------------------------------------------------------------------------
% mapping time to steps
%-------------------------------------------------------------------------------

% (time,S): the time of step S
&sum{ (time, 0) } >= 0.                                           % step 0 is at at time >= 0
&sum{ (time,S2); -(time,S1) } > 0 :- step(S1), step(S2), S2=S1+1. % consecutive steps must have greater time

%
% Observations
%
:- obs(_,_,T), T < 0.
:- obs(_,_,T), T > maxtime, not disable_laststep. % last step can be disabled

% happens3
:- obs(_,_,T1,T2), T1 < 0.
:- obs(_,_,T1,T2), T2 > maxtime, not disable_laststep. % last step can be disabled

% map(T,S): time T is mapped to state S
%   map(T,S) :- obs(happens3,E,T), step(S), &sum{ (time,S) } = T.       % clingcon
    map(T,S) :- obs(happens3,E,T,_), step(S), sum(( (1,(time,S)) ),eq,T). % clingo-lpx
    map(T,S) :- obs(happens3,E,_,T), step(S), sum(( (1,(time,S)) ),eq,T). % clingo-lpx
             :- obs(happens3,E,_,T), not map(T,_). 
             :- obs(happens3,E,T,_), not map(T,_). 
happens3(E,S1,S2) :- obs(happens3,E,T1,T2), map(T1,S1), map(T2,S2).

% time_step(T,S): time point T corresponds to step S 
%% clingcon
%time_step(T,S) :- obs(O,_,T), O != happens, step(S), S > 0, &sum{ (time,S-1) } < T, &sum{ (time,S) } >= T. % (time,S-1) < T <= (time,S)
%time_step(T,S) :- obs(O,_,T), O != happens,          S = 0,                         &sum{ (time,S) } >= T. %              T <= (time,S)
% clingo-lpx
time_step(T,S) :- obs(O,_,T), O != happens3, step(S), S > 0, sum(( (1,(time,S1)) ),lt,T), sum(( (1,(time,S)) ),geq,T), S1 = S-1. % (time,S-1) < T <= (time,S)
time_step(T,S) :- obs(O,_,T), O != happens3,          S = 0,                              sum(( (1,(time,S)) ),geq,T).           %              T <= (time,S)
:- obs(O,_,T), O != happens3, not time_step(T, _). % TODO added this
%time_step_obs((holdsAt;notHoldsAt;releasedAt;notReleasedAt)). % filter out happens and functional values

% check Boolean fluents' observations
:- obs(      holdsAt,F,T),  fluent(F), time_step(T,S), not holdsAt(F,S).
:- obs(   notHoldsAt,F,T),  fluent(F), time_step(T,S),     holdsAt(F,S).
:- obs(   releasedAt,F,T),  fluent(F), time_step(T,S), not releasedAt(F,S).
:- obs(   releasedAt,F,T), ffluent(F), time_step(T,S), not releasedAt(F,S).
:- obs(notReleasedAt,F,T),  fluent(F), time_step(T,S),     releasedAt(F,S).
:- obs(notReleasedAt,F,T), ffluent(F), time_step(T,S),     releasedAt(F,S).

% check functional fluents' observations
% in_trajectory(F,S,C): F is at step S in a trajectory with time coefficient C
in_trajectory(F2,S4,C) :- 
  S4=S2+S3, happens3(E,S1,S2), initiates(E,F1,S1), 0<S3,
  trajectory(F1,S1,F2,(LE,C),S3), not stoppedIn(S1,F1,S4), step(S4).
%
in_trajectory(F2,S4,C) :- 
  S4=S2+S3, happens3(E,S1,S2), terminates(E,F1,S1), 0<S3,
  antiTrajectory(F1,S1,F2,(LE,C),S3), not startedIn(S1,F1,S4), step(S4).

% TODO what about observation that value is greater than something
&sum{ (F,S) }                         = V :- obs(F,V,T), ffluent(F), time_step(T,S), not in_trajectory(F,S,_).
%&sum{ (F,S); C*T; -C*(time,S) } = V :- obs(F,V,T), ffluent(F), time_step(T,S),     in_trajectory(F,S,C).  % clingcon
&sum{ (F,S); C*(obs,T); -C*(time,S) } = V :- obs(F,V,T), ffluent(F), time_step(T,S),     in_trajectory(F,S,C).  % clingo-lpx 
&sum{(obs,T)} = T :- obs(_,_,T).  % TODO workaround for clingo-lpx (cant say C*T)

%%% %
%%% % Simpler option (creates more steps)
%%% %
%%% %map(T,S) :- obs(_,_,T), step(S), &sum{ (time,S) } = T. % clingcon
%%% map(T,S) :- obs(_,_,T), sum(((1,(time,S))),eq,T). % clingo-lpx
%%%          :- obs(_,_,T), not map(T,_). 
%%% 
%%%      happens(E,S) :- obs(      happens,E,T), map(T,S).
%%%                   :- obs(      holdsAt,F,T), map(T,S),  fluent(F), not holdsAt(F,S).
%%%                   :- obs(   notHoldsAt,F,T), map(T,S),  fluent(F),     holdsAt(F,S).
%%%                   :- obs(   releasedAt,F,T), map(T,S),  fluent(F), not releasedAt(F,S).
%%%                   :- obs(   releasedAt,F,T), map(T,S), ffluent(F), not releasedAt(F,S).
%%%                   :- obs(notReleasedAt,F,T), map(T,S),  fluent(F),     releasedAt(F,S).
%%%                   :- obs(notReleasedAt,F,T), map(T,S), ffluent(F),     releasedAt(F,S).
%%% &sum{ (F,S) } = V :- obs(            F,V,T), map(T,S), ffluent(F).
%%% % &sum{ (F,S) } = V :- obs( (F,    V),T), map(T,S), ffluent(F).
%%% %
%%% significant_step(S) :- map(T,S).

% for clingo-lpx
comparison(( (1,(time,S)) ),T) :- obs(_,_,T), step(S).
comparison(( (1,(time,S)) ),T) :- obs(_,_,T,_), step(S).
comparison(( (1,(time,S)) ),T) :- obs(_,_,_,T), step(S).

% maxstep maps to maxtime (unless disabled)
&sum{ (time,maxstep) } = maxtime :- not disable_laststep.


% func. atom that represents the time difference between each pair of timepoints

% TODO this constraint should not be strictly necessary, but disabling it leads to problems with bugs in clingo-lpx and makes things more complicated
% restrict free floating steps to avoid seeing useless steps:

:- step(S), not significant_step(S),                    % all steps must be significant
   not disable_significant_constr.                      % unless this constraint is disabled
significant_step(S) :- S=maxstep, not disable_laststep. % last step is significant (unless last step is disabled)
significant_step(S) :- happens3(E,S,_).                 % step is significant if an event happens
significant_step(S) :- happens3(E,_,S).                 % step is significant if an event happens


%-------------------------------------------------------------------------------
% helper predicates to make domain description easier/shorter
%-------------------------------------------------------------------------------

% designating significant values of continuous fluents or time so that we do not miss them
comparison(( (1,(F,S-1)) ),V) :- no_jump(F,S,V), step(S), step(S-1).
comparison(( (1,(F,S  )) ),V) :- no_jump(F,S,V), step(S), step(S-1). 
%
:- no_jump(F,S,V), sum(( (1,(F,S-1)) ),lt,V), sum(( (1,(F,S)) ),gt,V).
:- no_jump(F,S,V), sum(( (1,(F,S-1)) ),gt,V), sum(( (1,(F,S)) ),lt,V).


%-------------------------------------------------------------------------------
% Defined
%-------------------------------------------------------------------------------

% define #const maxstep
% define #const maxtime

#defined no_jump/3.
#defined obs/3.
#defined obs/4.

#defined initiallyP/1.
#defined initiallyN/1.
#defined initiallyP/2.

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

% below was added to make these axioms compatible with the BEC/DBEC examples without a need to modify the examples
:- holdsAt(F, 0), initiallyN(F), fluent(F).
holdsAt(F, 0) :- initiallyP(F), fluent(F).
&sum{ (F,0) } = V :- initiallyP(F, V), ffluent(F).
