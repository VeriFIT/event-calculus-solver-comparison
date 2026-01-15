TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=python ../fdec-incr.py --maxtime $$MAXTIME
#LPX_CMD=python -m clingolpx --enable-python --strict -n0 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
CON_CMD=python ../fdec-incr.py --maxtime $$MAXTIME --con
#CON_CMD=python -m clingcon --enable-python -n0 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp ./narrative1.lp 
run-lpx-nocatch:
	MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp ./narrative2.lp --no_last_step --keep_going --minstep 8 --maxstep 10
run-lpx-nosig:
	MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp ./narrative1.lp --no_signifstep
#run-lpx-nocatch-nosig:	# does not work here since last step is disabled
#	MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp ./narrative2.lp --no_last_step --no_signifstep --keep_going --minstep 8 --maxstep 10


run-con: # TODO currently not working, uses rational numbers
	MAXTIME=1000; ${TIME} ${CON_CMD} ./model.lp ./narrative1.lp --keep_going
run-con-nocatch:  # TODO currently not working, uses rational numbers
	MAXTIME=1000; ${TIME} ${CON_CMD} ./model.lp ./narrative2.lp --no_last_step --keep_going


#-----------------------------------------------------------------------------------------------------------------------
# fixed zeno

run-lpx-fix-flat_loss:
	MAXTIME=1000; ${TIME} ${LPX_CMD} ./fix-flat_loss.lp ./narrative2.lp
run-lpx-fix-min_dur:
	MAXTIME=1000; ${TIME} ${LPX_CMD} ./fix-min_dur.lp ./narrative2.lp
	
run-lpx-fix-flat_loss-nosig:
	MAXTIME=1000; ${TIME} ${LPX_CMD} ./fix-flat_loss.lp ./narrative2.lp --no_signifstep
run-lpx-fix-min_dur-nosig:	# TODO causes problems here (many models with 'e')
	MAXTIME=1000; ${TIME} ${LPX_CMD} ./fix-min_dur.lp ./narrative2.lp --no_signifstep
	

#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	MODEL=model; 			NAME=;		MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp ./narrative1.lp" ./logs/lpx-$$MODEL$$NAME.log ; exit 0
	MODEL=model; 			NAME=many	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp ./narrative2.lp --no_last_step --keep_going --minstep 8 --maxstep 10" ./logs/lpx-$$MODEL$$NAME.log ; exit 0
	MODEL=fix-flat_loss; 	NAME=;		MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp ./narrative2.lp" ./logs/lpx-$$MODEL$$NAME.log ; exit 0
	MODEL=fix-min_dur; 	 	NAME=;		MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp ./narrative2.lp" ./logs/lpx-$$MODEL$$NAME.log ; exit 0
