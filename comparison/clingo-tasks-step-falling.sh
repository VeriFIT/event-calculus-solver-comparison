#!/bin/bash

RUN="clingo ./axioms/dec_clingo.lp ./axioms/dec_clingo-show.lp"

maxEvents=102
maxInEvents=52
stepEvents=5
#maxEvents=10
#maxInEvents=5  # each input event causes one triggered event
#stepEvents=1

precisionT="1 2" 
precisionV="1 2" 
for PT in $precisionT
do
    for PV in $precisionV
    do
        for E in $(seq 1 $stepEvents $maxInEvents)
        do
            MINSTEP=$(($E+$E)) # each input event causes one triggered event
            echo "PT$PT-PV$PV-E$MINSTEP;'$RUN -n10 ./ex3-falling_object/model-configurable.lp -c eventsNumber=$E -c maxEventsNumber=$maxEvents -c precisionMultTime=$PT -c precisionMultVal=$PV';1"
        done
    done
done





