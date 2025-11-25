TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=clingo-lpx --strict -n0 ../axioms/fdec.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
LPX_CMD_FH=clingo-lpx --strict -n0 ../axioms/fdec-ffholds.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx-effect:
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-effect_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state:
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-state_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state-cont:
	MAXSTEP=9; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-state_constr-continuous.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-effect-fh:
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-effect_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state-fh:
	MAXSTEP=5; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-state_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state-cont-fh:
	MAXSTEP=9; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-state_constr-continuous-fh.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_DBEC=clingo-lpx --strict -n0 ../axioms/dbec-clingo_lpx-choice.lp -c maxstep=$$MAXSTEP
#TODO#LPX_CMD_EFF=clingo-lpx --strict -n0 ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

run-lpx-effect-dbec:
	MAXSTEP=5; ${TIME} ${LPX_CMD_DBEC} ./model-effect_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state-dbec:
	MAXSTEP=5; ${TIME} ${LPX_CMD_DBEC} ./model-state_constr.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-state-cont-dbec:
	MAXSTEP=9; ${TIME} ${LPX_CMD_DBEC} ./model-state_constr-continuous.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	MODEL=-effect_constr;			NAME=; 		MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr;			NAME=; 		MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr-continuous;	NAME=; 		MAXSTEP=9;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

	MODEL=-effect_constr;			NAME=-fh;	MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./model$$MODEL.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr;			NAME=-fh;	MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./model$$MODEL.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr-continuous;	NAME=-fh;	MAXSTEP=9;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

	MODEL=-effect_constr;			NAME=-dbec;	MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr;			NAME=-dbec;	MAXSTEP=5;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-state_constr-continuous;	NAME=-dbec;	MAXSTEP=9;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./model$$MODEL$$NAME.lp		| ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
