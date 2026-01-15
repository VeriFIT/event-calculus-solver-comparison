TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=python ../fdec-incr.py --maxtime $$MAXTIME
#LPX_CMD=python -m clingolpx --enable-python --strict -n0 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
CON_CMD=python ../fdec-incr.py --maxtime $$MAXTIME --con
#CON_CMD=python -m clingcon --enable-python -n0 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXTIME=19; ${TIME} ${LPX_CMD} ./model.lp
run-lpx-nosig:
	MAXTIME=19; ${TIME} ${LPX_CMD} ./model.lp --no_signifstep

run-lpx-10:
	MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp --no_last_step --keep_going --minstep 8 --maxstep 10


run-con: # TODO currently not working, uses rational numbers
	MAXTIME=19; ${TIME} ${CON_CMD} ./model.lp
run-con-10: # TODO currently not working, uses rational numbers
	MAXTIME=1000; ${TIME} ${CON_CMD} ./model.lp --no_last_step


#-----------------------------------------------------------------------------------------------------------------------
# fixed zeno

run-lpx-fix:
	MAXTIME=22; ${TIME} ${LPX_CMD} ./model-fixed.lp
run-lpx-fix-nosig:
	MAXTIME=22; ${TIME} ${LPX_CMD} ./model-fixed.lp --no_signifstep
	

#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	MODEL=; 			NAME=;		MAXTIME=19;		../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp" ./logs/lpx$$MODEL$$NAME.log ; exit 0
	MODEL=; 			NAME=many;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp --no_last_step --keep_going --minstep 8 --maxstep 10" ./logs/lpx$$MODEL$$NAME.log ; exit 0
	MODEL=-fixed; 		NAME=;		MAXTIME=22;		../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp" ./logs/lpx$$MODEL$$NAME.log ; exit 0
