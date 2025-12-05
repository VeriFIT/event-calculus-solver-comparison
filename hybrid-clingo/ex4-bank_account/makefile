TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD_ZENO=clingo-lpx --strict -n10 ./model-zeno.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
LPX_CMD=clingo-lpx --strict -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx-zeno:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_ZENO}  | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-nosig:	# TODO causes problems here (many models with 'e') -- maybe clingo-lpx bug
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD} -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_EFF=clingo-lpx --strict -n10 ./model-efficient.lp ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

run-lpx-eff:
	MAXSTEP=2; ${TIME} ${LPX_CMD_EFF} | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	NAME=-zeno	MAXSTEP=6;	MAXTIME=1000;  ../../scripts/maketrace.sh "${LPX_CMD_ZENO} 	| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP.log ; exit 0
	NAME=;		MAXSTEP=6;	MAXTIME=1000;  ../../scripts/maketrace.sh "${LPX_CMD} 		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP.log ; exit 0
	
	NAME=-eff; 	MAXSTEP=6;	MAXTIME=1000;  ../../scripts/maketrace.sh "${LPX_CMD_EFF} 	| ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP.log ; exit 0
