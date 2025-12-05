
%% define a fact "debug_prints." to switch to debug prints instead of fancy prints
%debug_prints.

%% define a fact "negated_prints." to show negated versions of fluent values
%negated_prints.

#show.

#show happens(E,ftimeAtStep(T)) : happens(E,T), not debug_prints.

%% discrete fluents have values between steps
#show holdsAt(F, (ftimeAtStep(T), "< T =<", ftimeAtStep(T+1))) :  holdsAt(F, T+1), time(T), time(T+1), dfluent(F), not debug_prints.
#show -holdsAt(F, (ftimeAtStep(T), "< T =<", ftimeAtStep(T+1))) :  not holdsAt(F, T+1), time(T), time(T+1), dfluent(F), not debug_prints, negated_prints.

%%% discrete fluents can be released between steps
#show releasedAt(F, (ftimeAtStep(T), "< T =<", ftimeAtStep(T+1))) :  releasedAt(F, T+1), time(T), time(T+1), fluent(F), not debug_prints.
#show -releasedAt(F, (ftimeAtStep(T), "< T =<", ftimeAtStep(T+1))) :  not releasedAt(F, T+1), time(T), time(T+1), fluent(F), not debug_prints, negated_prints.
 
%% functional fluents have values between steps
#show fholdsAt(F, fholdsAt(F,T+1), (ftimeAtStep(T), "< T =<", ftimeAtStep(T+1))) :
  % holdsAt(F, T+1),  % functional fluents always hold
  not anyTrajectory(F, T+1), time(T), time(T+1), ffluent(F), not debug_prints.
anyTrajectory(F2, T2) :- not debug_prints,
  T1 < T2,
  initiates(E, F1, T1),
  happens(E, T1),
  trajectory(F1, T1, F2, _, T2),
  not stoppedIn(T1, F1, T2),
  time(T1), time(T2).
anyTrajectory(F2, T2) :- not debug_prints,
  T1 < T2,
  terminates(E, F1, T1),
  happens(E, T1),
  antiTrajectory(F1, T1, F2, _, T2),
  not stoppedIn(T1, F1, T2),
  time(T1), time(T2).
#show -fholdsAt(F, (ftimeAtStep(T), "< T =<", ftimeAtStep(T+1))) :
  not holdsAt(F, T+1), time(T), time(T+1), ffluent(F), not debug_prints, negated_prints.

%% functional fluents can be continuous with their value defined by a trajectory (continuous value between steps)
#show fholdsAtC(F2, (fholdsAt(F2, T), "->", fholdsAt(F2, T+1)), (ftimeAtStep(T), "< T =<", ftimeAtStep(T+1)), eq(off1(A1), "*", koef1(A2), "+", koef2(B), "*", base(fholdsAt(F2,SStart)), "+", inc(INC), "*", dur(ftimeAtStep(T+1), "-", ftimeAtStep(SStart)))) :
  SStart < T+1,
  initiates(E, F1, SStart),
  happens(E, SStart),
  trajectory(F1, SStart, F2, (A1,A2,B,F2,INC), T+1),
  not stoppedIn(SStart, F1, T+1),
  time(T), time(T+1), time(SStart),
  not debug_prints.
#show fholdsAtC(F2, (fholdsAt(F2, T), "->", fholdsAt(F2, T+1)), (ftimeAtStep(T), "< T =<", ftimeAtStep(T+1)), eq(off1(A1), "*", koef1(A2), "+", koef2(B), "*", base(fholdsAt(F2,SStart)), "+", inc(INC), "*", dur(ftimeAtStep(T+1), "-", ftimeAtStep(SStart)))) :
  SStart < T+1,
  terminates(E, F1, SStart),
  happens(E, SStart),
  antiTrajectory(F1, SStart, F2, (A1,A2,B,F2,INC), T+1),
  not stoppedIn(SStart, F1, T+1),
  time(T), time(T+1), time(SStart),
  not debug_prints.

% show all for debug
#show happens(E,T) : happens(E,T), debug_prints.
#show holdsAt(F,T) : holdsAt(F,T), debug_prints.
#show releasedAt(F,T) : releasedAt(F,T), debug_prints.

#show map(GT, S) : map(GT, S), debug_prints.
