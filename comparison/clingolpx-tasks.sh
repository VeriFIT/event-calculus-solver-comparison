#!/bin/bash

RUN_LPX="python ./fdec-incr.py"

##name;command;expectedmodels
#tasks="
#1-BusRide2;'$RUN_LPX ./ec2asp-examples/BusRide2-ea.lp';1
#1-BusRide40;'$RUN_LPX ./ec2asp-examples/BusRide40-ea.lp';1
#1-ChessBoard2;'$RUN_LPX ./ec2asp-examples/ChessBoard2-ea.lp';3
#1-ChessBoard40;'$RUN_LPX ./ec2asp-examples/ChessBoard40-ea.lp';3
#1-CoinToss4;'$RUN_LPX ./ec2asp-examples/CoinToss4-ea.lp';8
#1-CoinToss40;'$RUN_LPX ./ec2asp-examples/CoinToss40-ea.lp';8
#1-Commuter15;'$RUN_LPX  --no_axioms ./axioms/fdec_dur.lp ./axioms/fdec_dur-show.lp ./ec2asp-examples/Commuter15-ea.lp';1
#1-DeadOrAlive3;'$RUN_LPX ./ec2asp-examples/DeadOrAlive3-ea.lp';1
#1-DeadOrAlive40;'$RUN_LPX ./ec2asp-examples/DeadOrAlive40-ea.lp';1
#1-Happy2;'$RUN_LPX ./ec2asp-examples/Happy2-ea.lp';1
#1-Happy40;'$RUN_LPX ./ec2asp-examples/Happy40-ea.lp';1
#1-KitchenSink5;'$RUN_LPX ./ec2asp-examples/KitchenSink_M5-ea.lp';1
#1-KitchenSink25;'$RUN_LPX ./ec2asp-examples/KitchenSink_M25-ea.lp';1
#1-KitchenSink40;'$RUN_LPX ./ec2asp-examples/KitchenSink_M40-ea.lp';1
#1-RussianTurkey4;'$RUN_LPX ./ec2asp-examples/RussianTurkey4-ea.lp';2
#1-RussianTurkey40;'$RUN_LPX ./ec2asp-examples/RussianTurkey40-ea.lp';2
#1-StolenCar2;'$RUN_LPX ./ec2asp-examples/StolenCar2-ea.lp';1
#1-StolenCar40;'$RUN_LPX ./ec2asp-examples/StolenCar40-ea.lp';1
#1-StuffyRoom2;'$RUN_LPX ./ec2asp-examples/StuffyRoom2-ea.lp';1
#1-StuffyRoom40;'$RUN_LPX ./ec2asp-examples/StuffyRoom40-ea.lp';1
#1-SuperMarket12;'$RUN_LPX ./ec2asp-examples/Supermarket12-ea.lp';1
#1-SuperMarket40;'$RUN_LPX ./ec2asp-examples/Supermarket40-ea.lp';1
#1-ThielscherCircuit1;'$RUN_LPX ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit1-ea.lp';1
#1-ThielscherCircuit20;'$RUN_LPX ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit20-ea.lp';1
#1-ThielscherCircuit40;'$RUN_LPX ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp';1
#1-WalkingTurkey3;'$RUN_LPX ./ec2asp-examples/WalkingTurkey3-ea.lp';1
#1-WalkingTurkey40;'$RUN_LPX ./ec2asp-examples/WalkingTurkey40-ea.lp';1
#1-Yale3;'$RUN_LPX ./ec2asp-examples/Yale3-ea.lp';1
#1-Yale40;'$RUN_LPX ./ec2asp-examples/Yale40-ea.lp';1
#2-FallingObjectWithAntiTrajectory5;'$RUN_LPX ./ec2asp-examples/FallingObjectWithAntiTrajectory5-ea.lp';1
#2-FallingObjectWithAntiTrajectory15;'$RUN_LPX ./ec2asp-examples/FallingObjectWithAntiTrajectory15-ea.lp';1
#2-FallingObjectWithAntiTrajectory25;'$RUN_LPX ./ec2asp-examples/FallingObjectWithAntiTrajectory25-ea.lp';1
#2-FallingObjectWithEvents5;'$RUN_LPX ./ec2asp-examples/FallingObjectWithEvents5-ea.lp';1
#2-FallingObjectWithEvents20;'$RUN_LPX ./ec2asp-examples/FallingObjectWithEvents20-ea.lp';1
#2-FallingObjectWithEvents25;'$RUN_LPX ./ec2asp-examples/FallingObjectWithEvents25-ea.lp';1
#2-FallingObjectWithEvents40;'$RUN_LPX ./ec2asp-examples/FallingObjectWithEvents40-ea.lp';1
#2-HotAirBalloon3;'$RUN_LPX ./ec2asp-examples/HotAirBalloon3-ea.lp';1
#2-HotAirBalloon15;'$RUN_LPX ./ec2asp-examples/HotAirBalloon15-ea.lp';1
#2-HotAirBalloon20;'$RUN_LPX ./ec2asp-examples/HotAirBalloon20-ea.lp';1
#2-HotAirBalloon40;'$RUN_LPX ./ec2asp-examples/HotAirBalloon40-ea.lp';1
#2-Telephone3;'$RUN_LPX ./ec2asp-examples/Telephone3-ea.lp';1
#2-Telephone40;'$RUN_LPX ./ec2asp-examples/Telephone40-ea.lp';1
#"

DOM_START=50
DOM_STEP=50
DOM_MAX=10000

EXAMPLES="
BusRide
ChessBoard
CoinToss
DeadOrAlive
Happy
KitchenSink_M
RussianTurkey
StolenCar
StuffyRoom
Supermarket
WalkingTurkey
Yale
FallingObjectWithEvents
HotAirBalloon
Telephone
"

for EX in "$EXAMPLES"
do
    for DOM in $(seq $DOM_START $DOM_STEP $DOM_MAX)
    do
    echo "1-$EX-maxT$DOM;'$RUN_LPX ./ec2asp-examples/${EX}40-ea.lp --maxtime $DOM';1"
    done
done

EX="ThielscherCircuit"
for DOM in $(seq $DOM_START $DOM_STEP $DOM_MAX)
do
echo "1-$EX-maxT$DOM;'$RUN_LPX ./axioms/causal.lp ./ec2asp-examples/${EX}40-ea.lp --maxtime $DOM';1"

EX="Commuter"
for DOM in $(seq $DOM_START $DOM_STEP $DOM_MAX)
do
echo "1-$EX-maxT$DOM;'$RUN_LPX --no_axioms ./axioms/fdec_dur.lp ./axioms/fdec_dur-show.lp ./ec2asp-examples/${EX}15-ea.lp --maxtime $DOM';1"
done

EX="Counter"
for DOM in $(seq $DOM_START $DOM_STEP $DOM_MAX)
do
echo "1-Counter-maxT$DOM;'$RUN_LPX ./ex15-counter/model.lp --maxtime $DOM';1"
done
