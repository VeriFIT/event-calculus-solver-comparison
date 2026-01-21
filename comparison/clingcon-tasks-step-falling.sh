#!/bin/bash

RUN="python ./fdec-incr.py --con"

maxEvents=102
maxInEvents=52
stepEvents=5
#maxEvents=10
#maxInEvents=5  # each input event causes one triggered event
#stepEvents=1

precision="10" 
for P in $precision
do
    for E in $(seq 1 $stepEvents $maxInEvents)
    do
        MINSTEP=$(($E+$E)) # each input event causes one triggered event
        echo "     P$P-E$MINSTEP;'$RUN                    --maxstep $maxEvents -n10 ./ex3-falling_object/model-configurable.lp -c eventsNumber=$E -c maxEventsNumber=$maxEvents -c precisionMultTime=$P -c precisionMultVal=$P';1"
        echo "know-P$P-E$MINSTEP;'$RUN --minstep $MINSTEP --maxstep $maxEvents -n10 ./ex3-falling_object/model-configurable.lp -c eventsNumber=$E -c maxEventsNumber=$maxEvents -c precisionMultTime=$P -c precisionMultVal=$P';1"
    done
done