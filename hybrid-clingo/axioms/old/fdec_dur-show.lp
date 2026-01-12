% version of show FDEC for happens3 -- events with duration

%% define a fact "debug_prints." to switch to debug prints instead of fancy prints
%debug_prints.

%% define a fact "negated_prints." to show negated versions of fluent values
%negated_prints.

#show.

#show happens(E,time(S)) : happens(E,S), not debug_prints.
#show happens3(E,time(S1),time(S2)) : happens3(E,S1,S2), not debug_prints.

%% discrete fluents have values between steps
#show holdsAt(F, (time(S), "< S =<", time(S+1))) :  holdsAt(F, S+1), step(S), step(S+1), dfluent(F), not debug_prints.
#show -holdsAt(F, (time(S), "< S =<", time(S+1))) :  not holdsAt(F, S+1), step(S), step(S+1), dfluent(F), not debug_prints, negated_prints.

%%% discrete fluents can be released between steps
#show releasedAt(F, (time(S), "< S =<", time(S+1))) :  releasedAt(F, S+1), step(S), step(S+1), fluent(F), not debug_prints.
#show -releasedAt(F, (time(S), "< S =<", time(S+1))) :  not releasedAt(F, S+1), step(S), step(S+1), fluent(F), not debug_prints, negated_prints.
 
%% functional fluents have values between steps
#show fholdsAt(F, (F,S+1), (time(S), "< S =<", time(S+1))) :
  % holdsAt(F, S+1),  % functional fluents always hold
  not anyTrajectory(F, S+1), step(S), step(S+1), ffluent(F), not debug_prints.
anyTrajectory(F2, S3) :- not debug_prints,
  S2 < S3,
  initiates(E, F1, S1),
  happens3(E, S1, S2),
  trajectory(F1, S1, F2, _, S3),
  not stoppedIn(S1, F1, S3),
  step(S1), step(S2), step(S3).
anyTrajectory(F2, S3) :- not debug_prints,
  S2 < S3,
  terminates(E, F1, S1),
  happens3(E, S1, S2),
  antiTrajectory(F1, S1, F2, _, S3),
  not stoppedIn(S1, F1, S3),
  step(S1), step(S2), step(S3).
#show -fholdsAt(F, (time(S), "< S =<", time(S+1))) :
  not holdsAt(F, S+1), step(S), step(S+1), ffluent(F), not debug_prints, negated_prints.

%% functional fluents can be continuous with their value defined by a trajectory (continuous value between steps)
#show fholdsAtC(F2, ((F2, S), "->", (F2, S+1)), (time(S), "< S =<", time(S+1)), eq(off1(A1), "*", koef1(A2), "+", koef2(B), "*", base((F2,SEffect)), "+", inc(INC), "*", dur(time(S+1), "-", time(SEffect)))) :
  SEffect < S+1,
  initiates(E, F1, SStart),
  happens3(E, SStart, SEffect),
  trajectory(F1, SStart, F2, (A1,A2,B,F2,INC), S+1),
  not stoppedIn(SStart, F1, S+1),
  step(S), step(S+1), step(SStart),
  not debug_prints.
#show fholdsAtC(F2, ((F2, S), "->", (F2, S+1)), (time(S), "< S =<", time(S+1)), eq(off1(A1), "*", koef1(A2), "+", koef2(B), "*", base((F2,SEffect)), "+", inc(INC), "*", dur(time(S+1), "-", time(SEffect)))) :
  SEffect < S+1,
  terminates(E, F1, SStart),
  happens3(E, SStart, SEffect),
  antiTrajectory(F1, SStart, F2, (A1,A2,B,F2,INC), S+1),
  not stoppedIn(SStart, F1, S+1),
  step(S), step(S+1), step(SStart),
  not debug_prints.

% show all for debug
#show happens(E,S) : happens(E,S), debug_prints.
#show happens3(E,S1,S2) : happens3(E,S1,S2), debug_prints.
#show holdsAt(F,S) : holdsAt(F,S), debug_prints.
#show releasedAt(F,S) : releasedAt(F,S), debug_prints.

#show map(T, S) : map(T, S), debug_prints.
