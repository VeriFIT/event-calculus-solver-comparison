#show fholdsAt of a derived fluent does not check for continuous value (when the derived fluents is copying a value of
a continuous fluent that is changed via a trajectory)


when initiating a value of a ffluent or defining its value via a trajectory:
then maybe the (A,B,C,F) should be (A,B,C,F1,F2)
axioms would then have &sum{ A; B*(fholdsAt(F1,T) + C) } = fholdsAt(F2,T+1)
similar for trajectory
