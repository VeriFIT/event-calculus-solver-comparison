TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=python ../fdec-incr.py ./model.lp --maxtime $$MAXTIME
LPX_CMD_ZENO=python ../fdec-incr.py ./model-zeno.lp --maxtime $$MAXTIME
#LPX_CMD=python -m clingolpx --enable-python --strict -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
#LPX_CMD_ZENO=python -m clingolpx --enable-python --strict -n10 ./model-zeno.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
CON_CMD=python ../fdec-incr.py ./model-con.lp --maxtime $$MAXTIME --con
CON_CMD_ZENO=python ../fdec-incr.py ./model-zeno.lp --maxtime $$MAXTIME --con 
#CON_CMD=python -m clingcon --enable-python -n10 ./model-con.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
#CON_CMD_ZENO=python -m clingcon --enable-python -n10 ./model-zeno.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXTIME=1000; ${TIME} ${LPX_CMD} 
run-lpx-nosig:	# TODO causes problems here (many models with 'e') -- maybe clingo-lpx bug
	MAXTIME=1000; ${TIME} ${LPX_CMD} --no_signifstep
run-lpx-zeno:
	MAXTIME=1000; ${TIME} ${LPX_CMD_ZENO}  


run-con:
	MAXTIME=1000; ${TIME} ${CON_CMD} 
run-con-nosig:
	MAXTIME=1000; ${TIME} ${CON_CMD} --no_signifstep
run-con-zeno:	# TODO generates all combinations of placement of timepoints (can use --project to only see one)
	MAXTIME=1000; ${TIME} ${CON_CMD_ZENO} --project


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	NAME=-zeno	MAXTIME=1000;  ../../scripts/maketrace.sh "${LPX_CMD_ZENO} 	" ./logs/lpx$$NAME.log ; exit 0
	NAME=;		MAXTIME=1000;  ../../scripts/maketrace.sh "${LPX_CMD} 		" ./logs/lpx$$NAME.log ; exit 0
	
	NAME=-zeno	MAXTIME=1000;  ../../scripts/maketrace.sh "${CON_CMD_ZENO} --project" ./logs/con$$NAME.log ; exit 0
	NAME=;		MAXTIME=1000;  ../../scripts/maketrace.sh "${CON_CMD} 		" ./logs/con$$NAME.log ; exit 0
