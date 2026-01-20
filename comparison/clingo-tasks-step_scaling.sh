#!/bin/bash

RUN="clingo ./axioms/dec_clingo.lp"


maxEvents=101
precision="1 10" 
for P in $precision
do
    for E in $(seq 1 10 $maxEvents)
    do
    echo "P$P-E$E;'$RUN -n10 ./ex5-light_toggle/model-configurable.lp -c maxtime=$maxEvents*$P -c eventsNumber=$E' -c precision=$P;1"
    done
done





