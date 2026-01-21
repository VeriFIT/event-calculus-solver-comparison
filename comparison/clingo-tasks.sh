#!/bin/bash

RUN="clingo ./axioms/dec_clingo.lp ./axioms/dec_clingo-show.lp"

#name;command;expectedmodels
#tasks="
#1-BusRide2;'$RUN -n10 ./ec2asp-examples/BusRide2-ea.lp';1
#1-BusRide40;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp';1
#1-ChessBoard2;'$RUN -n10 ./ec2asp-examples/ChessBoard2-ea.lp';3
#1-ChessBoard40;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp';3
#1-CoinToss4;'$RUN -n10 ./ec2asp-examples/CoinToss4-ea.lp';8
#1-CoinToss40;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp';8
#1-Commuter15;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp';1
#1-DeadOrAlive3;'$RUN -n10 ./ec2asp-examples/DeadOrAlive3-ea.lp';1
#1-DeadOrAlive40;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp';1
#1-Happy2;'$RUN -n10 ./ec2asp-examples/Happy2-ea.lp';1
#1-Happy40;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp';1
#1-KitchenSink5;'$RUN -n10 ./ec2asp-examples/KitchenSink_M5-ea.lp';1
#1-KitchenSink25;'$RUN -n10 ./ec2asp-examples/KitchenSink_M25-ea.lp';1
#1-KitchenSink40;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp';1
#1-RussianTurkey4;'$RUN -n10 ./ec2asp-examples/RussianTurkey4-ea.lp';2
#1-RussianTurkey40;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp';2
#1-StolenCar2;'$RUN -n10 ./ec2asp-examples/StolenCar2-ea.lp';1
#1-StolenCar40;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp';1
#1-StuffyRoom2;'$RUN -n10 ./ec2asp-examples/StuffyRoom2-ea.lp';1
#1-StuffyRoom40;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp';1
#1-SuperMarket12;'$RUN -n10 ./ec2asp-examples/SuperMarket12-ea.lp';1
#1-SuperMarket40;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp';1
#1-ThielscherCircuit1;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit1-ea.lp';1
#1-ThielscherCircuit20;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit20-ea.lp';1
#1-ThielscherCircuit40;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp';1
#1-WalkingTurkey3;'$RUN -n10 ./ec2asp-examples/WalkingTurkey3-ea.lp';1
#1-WalkingTurkey40;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp';1
#1-Yale3;'$RUN -n10 ./ec2asp-examples/Yale3-ea.lp';1
#1-Yale40;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp';1;
#2-FallingObjectWithAntiTrajectory5;'$RUN -n10 ./ec2asp-examples/FallingObjectWithAntiTrajectory5-ea.lp';1
#2-FallingObjectWithAntiTrajectory15;'$RUN -n10 ./ec2asp-examples/FallingObjectWithAntiTrajectory15-ea.lp';1
#2-FallingObjectWithAntiTrajectory25;'$RUN -n10 ./ec2asp-examples/FallingObjectWithAntiTrajectory25-ea.lp';1
#2-FallingObjectWithEvents5;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents5-ea.lp';1
#2-FallingObjectWithEvents20;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents20-ea.lp';1
#2-FallingObjectWithEvents25;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents25-ea.lp';1
#2-FallingObjectWithEvents40;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp';1
#2-HotAirBalloon3;'$RUN -n10 ./ec2asp-examples/HotAirBalloon3-ea.lp';1
#2-HotAirBalloon15;'$RUN -n10 ./ec2asp-examples/HotAirBalloon15-ea.lp';1
#2-HotAirBalloon20;'$RUN -n10 ./ec2asp-examples/HotAirBalloon20-ea.lp';1
#2-HotAirBalloon40;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp';1
#2-Telephone3;'$RUN -n10 ./ec2asp-examples/Telephone3-ea.lp';1
#2-Telephone40;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp';1
#"

echo "
1-BusRide-maxT00050;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp -c maxtime=50';1
1-BusRide-maxT00100;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp -c maxtime=100';1
1-BusRide-maxT00200;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp -c maxtime=200';1
1-BusRide-maxT00400;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp -c maxtime=400';1
1-BusRide-maxT01000;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp -c maxtime=1000';1
1-BusRide-maxT02000;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp -c maxtime=2000';1
1-BusRide-maxT05000;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp -c maxtime=5000';1
1-BusRide-maxT10000;'$RUN -n10 ./ec2asp-examples/BusRide40-ea.lp -c maxtime=10000';1

1-ChessBoard-maxT00050;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp -c maxtime=50';3
1-ChessBoard-maxT00100;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp -c maxtime=100';3
1-ChessBoard-maxT00200;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp -c maxtime=200';3
1-ChessBoard-maxT00400;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp -c maxtime=400';3
1-ChessBoard-maxT01000;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp -c maxtime=1000';3
1-ChessBoard-maxT02000;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp -c maxtime=2000';3
1-ChessBoard-maxT05000;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp -c maxtime=5000';3
1-ChessBoard-maxT10000;'$RUN -n10 ./ec2asp-examples/ChessBoard40-ea.lp -c maxtime=10000';3

1-CoinToss-maxT00050;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp -c maxtime=50';8
1-CoinToss-maxT00100;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp -c maxtime=100';8
1-CoinToss-maxT00200;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp -c maxtime=200';8
1-CoinToss-maxT00400;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp -c maxtime=400';8
1-CoinToss-maxT01000;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp -c maxtime=1000';8
1-CoinToss-maxT02000;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp -c maxtime=2000';8
1-CoinToss-maxT05000;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp -c maxtime=5000';8
1-CoinToss-maxT10000;'$RUN -n10 ./ec2asp-examples/CoinToss40-ea.lp -c maxtime=10000';8

1-Commuter-maxT00050;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp -c maxtime=50';1
1-Commuter-maxT00100;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp -c maxtime=100';1
1-Commuter-maxT00200;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp -c maxtime=200';1
1-Commuter-maxT00400;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp -c maxtime=400';1
1-Commuter-maxT01000;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp -c maxtime=1000';1
1-Commuter-maxT02000;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp -c maxtime=2000';1
1-Commuter-maxT05000;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp -c maxtime=5000';1
1-Commuter-maxT10000;'clingo ./axioms/dec_clingo_dur.lp -n10 ./ec2asp-examples/Commuter15-ea.lp -c maxtime=10000';1

1-DeadOrAlive-maxT00050;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp -c maxtime=50';1
1-DeadOrAlive-maxT00100;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp -c maxtime=100';1
1-DeadOrAlive-maxT00200;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp -c maxtime=200';1
1-DeadOrAlive-maxT00400;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp -c maxtime=400';1
1-DeadOrAlive-maxT01000;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp -c maxtime=1000';1
1-DeadOrAlive-maxT02000;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp -c maxtime=2000';1
1-DeadOrAlive-maxT05000;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp -c maxtime=5000';1
1-DeadOrAlive-maxT10000;'$RUN -n10 ./ec2asp-examples/DeadOrAlive40-ea.lp -c maxtime=10000';1

1-Happy-maxT00050;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp -c maxtime=50';1
1-Happy-maxT00100;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp -c maxtime=100';1
1-Happy-maxT00200;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp -c maxtime=200';1
1-Happy-maxT00400;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp -c maxtime=400';1
1-Happy-maxT01000;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp -c maxtime=1000';1
1-Happy-maxT02000;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp -c maxtime=2000';1
1-Happy-maxT05000;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp -c maxtime=5000';1
1-Happy-maxT10000;'$RUN -n10 ./ec2asp-examples/Happy40-ea.lp -c maxtime=10000';1

1-KitchenSink-maxT00050;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp -c maxtime=50';1
1-KitchenSink-maxT00100;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp -c maxtime=100';1
1-KitchenSink-maxT00200;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp -c maxtime=200';1
1-KitchenSink-maxT00400;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp -c maxtime=400';1
1-KitchenSink-maxT01000;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp -c maxtime=1000';1
1-KitchenSink-maxT02000;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp -c maxtime=2000';1
1-KitchenSink-maxT05000;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp -c maxtime=5000';1
1-KitchenSink-maxT10000;'$RUN -n10 ./ec2asp-examples/KitchenSink_M40-ea.lp -c maxtime=10000';1

1-RussianTurkey-maxT00050;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp -c maxtime=50';2
1-RussianTurkey-maxT00100;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp -c maxtime=100';2
1-RussianTurkey-maxT00200;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp -c maxtime=200';2
1-RussianTurkey-maxT00400;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp -c maxtime=400';2
1-RussianTurkey-maxT01000;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp -c maxtime=1000';2
1-RussianTurkey-maxT02000;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp -c maxtime=2000';2
1-RussianTurkey-maxT05000;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp -c maxtime=5000';2
1-RussianTurkey-maxT10000;'$RUN -n10 ./ec2asp-examples/RussianTurkey40-ea.lp -c maxtime=10000';2

1-StolenCar-maxT00050;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp -c maxtime=50';1
1-StolenCar-maxT00100;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp -c maxtime=100';1
1-StolenCar-maxT00200;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp -c maxtime=200';1
1-StolenCar-maxT00400;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp -c maxtime=400';1
1-StolenCar-maxT01000;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp -c maxtime=1000';1
1-StolenCar-maxT02000;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp -c maxtime=2000';1
1-StolenCar-maxT05000;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp -c maxtime=5000';1
1-StolenCar-maxT10000;'$RUN -n1 ./ec2asp-examples/StolenCar40-ea.lp -c maxtime=10000';1

1-StuffyRoom-maxT00050;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp -c maxtime=50';1
1-StuffyRoom-maxT00100;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp -c maxtime=100';1
1-StuffyRoom-maxT00200;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp -c maxtime=200';1
1-StuffyRoom-maxT00400;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp -c maxtime=400';1
1-StuffyRoom-maxT01000;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp -c maxtime=1000';1
1-StuffyRoom-maxT02000;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp -c maxtime=2000';1
1-StuffyRoom-maxT05000;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp -c maxtime=5000';1
1-StuffyRoom-maxT10000;'$RUN -n10 ./ec2asp-examples/StuffyRoom40-ea.lp -c maxtime=10000';1

1-SuperMarket-maxT00050;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp -c maxtime=50';1
1-SuperMarket-maxT00100;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp -c maxtime=100';1
1-SuperMarket-maxT00200;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp -c maxtime=200';1
1-SuperMarket-maxT00400;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp -c maxtime=400';1
1-SuperMarket-maxT01000;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp -c maxtime=1000';1
1-SuperMarket-maxT02000;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp -c maxtime=2000';1
1-SuperMarket-maxT05000;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp -c maxtime=5000';1
1-SuperMarket-maxT10000;'$RUN -n10 ./ec2asp-examples/SuperMarket40-ea.lp -c maxtime=10000';1

1-ThielscherCircuit-maxT00050;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp -c maxtime=50';1
1-ThielscherCircuit-maxT00100;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp -c maxtime=100';1
1-ThielscherCircuit-maxT00200;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp -c maxtime=200';1
1-ThielscherCircuit-maxT00400;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp -c maxtime=400';1
1-ThielscherCircuit-maxT01000;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp -c maxtime=1000';1
1-ThielscherCircuit-maxT02000;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp -c maxtime=2000';1
1-ThielscherCircuit-maxT05000;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp -c maxtime=5000';1
1-ThielscherCircuit-maxT10000;'$RUN -n10 ./axioms/causal.lp ./ec2asp-examples/ThielscherCircuit40-ea.lp -c maxtime=10000';1

1-WalkingTurkey-maxT00050;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp -c maxtime=50';1
1-WalkingTurkey-maxT00100;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp -c maxtime=100';1
1-WalkingTurkey-maxT00200;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp -c maxtime=200';1
1-WalkingTurkey-maxT00400;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp -c maxtime=400';1
1-WalkingTurkey-maxT01000;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp -c maxtime=1000';1
1-WalkingTurkey-maxT02000;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp -c maxtime=2000';1
1-WalkingTurkey-maxT05000;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp -c maxtime=5000';1
1-WalkingTurkey-maxT10000;'$RUN -n10 ./ec2asp-examples/WalkingTurkey40-ea.lp -c maxtime=10000';1

1-Yale-maxT00050;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp -c maxtime=50';1
1-Yale-maxT00100;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp -c maxtime=100';1
1-Yale-maxT00200;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp -c maxtime=200';1
1-Yale-maxT00400;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp -c maxtime=400';1
1-Yale-maxT01000;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp -c maxtime=1000';1
1-Yale-maxT02000;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp -c maxtime=2000';1
1-Yale-maxT05000;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp -c maxtime=5000';1
1-Yale-maxT10000;'$RUN -n10 ./ec2asp-examples/Yale40-ea.lp -c maxtime=10000';1

2-FallingObjectWithEvents-maxT00050;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp -c maxtime=50';1
2-FallingObjectWithEvents-maxT00100;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp -c maxtime=100';1
2-FallingObjectWithEvents-maxT00200;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp -c maxtime=200';1
2-FallingObjectWithEvents-maxT00400;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp -c maxtime=400';1
2-FallingObjectWithEvents-maxT01000;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp -c maxtime=1000';1
2-FallingObjectWithEvents-maxT02000;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp -c maxtime=2000';1
2-FallingObjectWithEvents-maxT05000;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp -c maxtime=5000';1
2-FallingObjectWithEvents-maxT10000;'$RUN -n10 ./ec2asp-examples/FallingObjectWithEvents40-ea.lp -c maxtime=10000';1

2-HotAirBalloon-maxT00050;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp -c maxtime=50';1
2-HotAirBalloon-maxT00100;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp -c maxtime=100';1
2-HotAirBalloon-maxT00200;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp -c maxtime=200';1
2-HotAirBalloon-maxT00400;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp -c maxtime=400';1
2-HotAirBalloon-maxT01000;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp -c maxtime=1000';1
2-HotAirBalloon-maxT02000;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp -c maxtime=2000';1
2-HotAirBalloon-maxT05000;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp -c maxtime=5000';1
2-HotAirBalloon-maxT10000;'$RUN -n10 ./ec2asp-examples/HotAirBalloon40-ea.lp -c maxtime=10000';1

2-Telephone-maxT00050;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp -c maxtime=50';1
2-Telephone-maxT00100;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp -c maxtime=100';1
2-Telephone-maxT00200;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp -c maxtime=200';1
2-Telephone-maxT00400;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp -c maxtime=400';1
2-Telephone-maxT01000;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp -c maxtime=1000';1
2-Telephone-maxT02000;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp -c maxtime=2000';1
2-Telephone-maxT05000;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp -c maxtime=5000';1
2-Telephone-maxT10000;'$RUN -n10 ./ec2asp-examples/Telephone40-ea.lp -c maxtime=10000';1


3-Counter-maxT00050;'$RUN -n10 ./ex15-counter/model.lp -c maxtime=50';1
3-Counter-maxT00100;'$RUN -n10 ./ex15-counter/model.lp -c maxtime=100';1
3-Counter-maxT00200;'$RUN -n10 ./ex15-counter/model.lp -c maxtime=200';1
3-Counter-maxT00400;'$RUN -n10 ./ex15-counter/model.lp -c maxtime=400';1
3-Counter-maxT01000;'$RUN -n10 ./ex15-counter/model.lp -c maxtime=1000';1
3-Counter-maxT02000;'$RUN -n10 ./ex15-counter/model.lp -c maxtime=2000';1
3-Counter-maxT05000;'$RUN -n10 ./ex15-counter/model.lp -c maxtime=5000';1
3-Counter-maxT10000;'$RUN -n10 ./ex15-counter/model.lp -c maxtime=10000';1
"









