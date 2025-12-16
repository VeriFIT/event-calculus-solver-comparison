TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=clingo-lpx --strict -n10 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
CON_CMD=clingcon -n10 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx-effect:
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-effect_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state:
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-state_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state-cont:
	MAXSTEP=9; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-state_constr-continuous.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh


run-lpx-effect-nosig:		# works for this example
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${LPX_CMD} -c disablesignificantconstr=1 ./model-effect_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state-nosig:		# works for this example
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${LPX_CMD} -c disablesignificantconstr=1 ./model-state_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state-cont-nosig:		# works for this example
	MAXSTEP=9; MAXTIME=1000; ${TIME} ${LPX_CMD} -c disablesignificantconstr=1 ./model-state_constr-continuous.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh


run-con-effect:
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${CON_CMD} ./model-effect_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-con-state:
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${CON_CMD} ./model-state_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-con-state-cont:
	MAXSTEP=9; MAXTIME=1000; ${TIME} ${CON_CMD} ./model-state_constr-continuous.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_TDUR=clingo-lpx --strict -n10 ../axioms/fdec-tdur.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
#TODO#LPX_CMD_EFF=clingo-lpx --strict -n10 ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

run-lpx-state-cont-tdur:
	MAXSTEP=9; MAXTIME=1000; ${TIME} ${LPX_CMD_TDUR} ./model-state_constr-continuous-tdur.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh

#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	MODEL=-effect_constr;			NAME=; 		MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr;			NAME=; 		MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr-continuous;	NAME=; 		MAXSTEP=9;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

	MODEL=-state_constr-continuous;	NAME=-tdur;	MAXSTEP=9;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_TDUR} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	
	MODEL=-effect_constr;			NAME=; 		MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${CON_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr;			NAME=; 		MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${CON_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr-continuous;	NAME=; 		MAXSTEP=9;	MAXTIME=1000;	../../scripts/maketrace.sh "${CON_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
