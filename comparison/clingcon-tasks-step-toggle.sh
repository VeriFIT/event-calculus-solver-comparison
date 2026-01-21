#!/bin/bash

RUN="python ./fdec-incr.py --con"

maxEvents=101
precision="10" 
for P in $precision
do
    for E in $(seq 1 10 $maxEvents)
    do
    echo "P$P-E$E;'$RUN --maxstep $maxEvents -n10 ./ex5-light_toggle/model-configurable.lp -c maxtime=$maxEvents*$P -c eventsNumber=$E -c precision=$P';1"
    echo "know-P$P-E$E;'$RUN --minstep $E --maxstep $maxEvents -n10 ./ex5-light_toggle/model-configurable.lp -c maxtime=$maxEvents*$P -c eventsNumber=$E -c precision=$P';1"
    done
done





