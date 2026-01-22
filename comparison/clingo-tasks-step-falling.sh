#!/bin/bash

RUN="clingo ./axioms/dec_clingo.lp ./axioms/dec_clingo-show.lp"

maxEvents=102
maxInEvents=52
stepEvents=2
#maxEvents=10
#maxInEvents=5  # each input event causes one triggered event
#stepEvents=1

precisionT="1 4" 
precisionV="1 4" 
for PT in $precisionT
do
    for PV in $precisionV
    do
        for E in $(seq 1 $stepEvents $maxInEvents)
        do
            MINSTEP=$(($E+$E)) # each input event causes one triggered event
            echo "PT$PT-PV$PV-E$MINSTEP;'$RUN -n10 ./ex3-falling_object/model-configurable.lp -c eventsNumber=$E -c maxEventsNumber=$maxInEvents -c precisionMultTime=$PT -c precisionMultVal=$PV';1"
        done
    done
done





