
%% define a fact "debug_prints." to switch to debug prints instead of fancy prints
%debug_prints.

%% define a fact "negated_prints." to show negated versions of fluent values
%negated_prints.

#show.

#show maxStep(MAX) : MAX=maxstep.

#show happens(E,(time, S)) : happens(E,S), not debug_prints.

%% discrete fluents have values between steps
#show holdsAt(F, ((time, S), "< S =<", (time, S+1))) :  holdsAt(F, S+1), step(S), step(S+1), fluent(F), not debug_prints.
#show -holdsAt(F, ((time, S), "< S =<", (time, S+1))) :  not holdsAt(F, S+1), step(S), step(S+1), fluent(F), not debug_prints, negated_prints.

%%% discrete fluents can be released between steps
#show releasedAt(F, ((time, S), "< S =<", (time, S+1))) :  releasedAt(F, S+1), step(S), step(S+1), fluent(F), not debug_prints.
#show -releasedAt(F, ((time, S), "< S =<", (time, S+1))) :  not releasedAt(F, S+1), step(S), step(S+1), fluent(F), not debug_prints, negated_prints.
 
%% functional fluents have values between steps
#show fholdsAt(F, (F,S+1), ((time, S), "< S =<", (time, S+1))) :
  % holdsAt(F, S+1),  % functional fluents always hold
  not anyTrajectory(F, S+1), step(S), step(S+1), ffluent(F), not debug_prints.
anyTrajectory(F2, S2) :- not debug_prints,
  S1 < S2,
  initiates(E, F1, S1),
  happens(E, S1),
  trajectory(F1, S1, F2, _, S2),
  not stoppedIn(S1, F1, S2),
  step(S1), step(S2).
anyTrajectory(F2, S2) :- not debug_prints,
  S1 < S2,
  terminates(E, F1, S1),
  happens(E, S1),
  antiTrajectory(F1, S1, F2, _, S2),
  not stoppedIn(S1, F1, S2),
  step(S1), step(S2).
%%%#show -fholdsAt(F, ((time, S), "< S =<", (time, S+1))) :
%%%  not holdsAt(F, S+1), step(S), step(S+1), ffluent(F), not debug_prints, negated_prints.

%% functional fluents can be continuous with their value defined by a trajectory (continuous value between steps)
#show fholdsAtC(F2, ((F2, SStart+Dur-1), "->", (F2, SStart+Dur)), ((time, SStart+Dur-1), "< S =<", (time, SStart+Dur)), EQ) :
  happens(E, SStart),
  initiates(E, F1, SStart),
  trajectory(F1, SStart, F2, EQ, Dur),
  not stoppedIn(SStart, F1, SStart+Dur),
  Dur > 0,
  step(SStart+Dur-1), step(SStart+Dur), step(SStart),
  not debug_prints.
#show fholdsAtC(F2, ((F2, SStart+Dur-1), "->", (F2, SStart+Dur)), ((time, SStart+Dur-1), "< S =<", (time, SStart+Dur)), EQ) :
  happens(E, SStart),
  terminates(E, F1, SStart),
  antiTrajectory(F1, SStart, F2, EQ, Dur),
  not stoppedIn(SStart, F1, SStart+Dur),
  Dur > 0,
  step(SStart+Dur-1), step(SStart+Dur), step(SStart),
  not debug_prints.

% show all for debug
#show happens(E,S) : happens(E,S), debug_prints.
#show holdsAt(F,S) : holdsAt(F,S), debug_prints.
#show releasedAt(F,S) : releasedAt(F,S), debug_prints.

#show map(T, S) : map(T, S), debug_prints.
