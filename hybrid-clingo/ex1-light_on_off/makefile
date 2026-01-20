TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=python ../fdec-incr.py ./model.lp --maxtime $$MAXTIME
#LPX_CMD=python -m clingolpx --enable-python --strict -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
CON_CMD=python ../fdec-incr.py ./model.lp --maxtime $$MAXTIME --con
#CON_CMD=python -m clingcon --enable-python -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXTIME=1000; ${TIME} ${LPX_CMD}
run-lpx-nosig:
	MAXTIME=1000; ${TIME} ${LPX_CMD} --no_signifstep


run-con:
	MAXTIME=1000; ${TIME} ${CON_CMD}
run-con-nosig:
	MAXTIME=1000; ${TIME} ${CON_CMD} --no_signifstep


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log-lpx:
	@mkdir -p ./logs ; rm -f ./logs/lpx*.log
	NAME=; MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD}" ./logs/lpx$$NAME.log ; exit 0

log-con:
	@mkdir -p ./logs ; rm -f ./logs/con*.log
	NAME=; MAXTIME=1000;	../../scripts/maketrace.sh "${CON_CMD}" ./logs/con$$NAME.log ; exit 0
