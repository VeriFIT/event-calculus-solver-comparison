TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"

#AXIOMS=../axioms/bec_clingo.lp
#AXIOMS=../axioms/dbec_clingo.lp
AXIOMS=../axioms/dec_clingo.lp ../axioms/dec_clingo-show.lp
#AXIOMS=../axioms/ec_clingo.lp

#-----------------------------------------------------------------------------------------------------------------------
# base

CMD=clingo -c maxtime=$$MAXTIME -n 0 ${AXIOMS} ./model.lp
run:
	MAXTIME=30; ${TIME} ${CMD}


#-----------------------------------------------------------------------------------------------------------------------
# alternatives (fixes / improvements)


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	MAXTIME=30;   ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME.log ; exit 0
	MAXTIME=60;   ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME.log ; exit 0
	MAXTIME=120;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME.log ; exit 0
	MAXTIME=240;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME.log ; exit 0
	MAXTIME=480;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME.log ; exit 0
	MAXTIME=1000; ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME.log ; exit 0
