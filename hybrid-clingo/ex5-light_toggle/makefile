TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=python -m clingolpx --enable-python --strict -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
CON_CMD=python -m clingcon --enable-python -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXSTEP=3; MAXTIME=1000; ${TIME} ${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-nosig:	# works for this example
	MAXSTEP=3; MAXTIME=1000; ${TIME} ${LPX_CMD} -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


run-con:
	MAXSTEP=3; MAXTIME=1000; ${TIME} ${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_EFF=python -m clingolpx --enable-python --strict -n10 ./model-efficient.lp ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

run-lpx-eff:
	MAXSTEP=2; ${TIME} ${LPX_CMD_EFF} | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} 		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP.log ; exit 0

	NAME=-eff; 	MAXSTEP=2;	../../scripts/maketrace.sh "${LPX_CMD_EFF} 	| ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP.log ; exit 0
	
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	../../scripts/maketrace.sh "${CON_CMD} 		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$NAME-s$$MAXSTEP.log ; exit 0