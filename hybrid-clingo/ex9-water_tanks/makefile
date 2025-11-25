TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=clingo-lpx --strict -n0 ../axioms/fdec.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
LPX_CMD_FH=clingo-lpx --strict -n0 ../axioms/fdec-ffholds.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp -c disablelaststep=1  | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-50:
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-fh:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-50-fh:
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# fixed zeno

run-lpx-fix:
	MAXSTEP=11; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-fixed.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	
run-lpx-fix2:
	MAXSTEP=14; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-fixed2.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	

run-lpx-fix-fh:
	MAXSTEP=11; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-fixed.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	
run-lpx-fix2-fh:
	MAXSTEP=14; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-fixed2.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_DBEC=clingo-lpx --strict -n0 ../axioms/dbec-clingo_lpx-choice.lp -c maxstep=$$MAXSTEP
LPX_CMD_EFF=clingo-lpx --strict -n0 ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

run-lpx-dbec:
	MAXSTEP=6; ${TIME} ${LPX_CMD_DBEC} ./model-dbec.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-50-dbec:
	MAXSTEP=50; ${TIME} ${LPX_CMD_DBEC} ./model-dbec.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
# TODO this one is currently broken -- needs to be updated to match the solution in run-lpx-fix-fh
run-lpx-fix-dbec:
	MAXSTEP=10; ${TIME} ${LPX_CMD_DBEC} ./model-fixed-dbec.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-fix2-dbec:
	MAXSTEP=13; ${TIME} ${LPX_CMD_DBEC} ./model-fixed2-dbec.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh

#TODO#run-lpx-eff:
#TODO#	MAXSTEP=6; ${TIME} ${LPX_CMD_EFF} ./model-efficient.lp | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	MODEL=; 			NAME=;		MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=; 			NAME=;		MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-fixed; 		NAME=;		MAXSTEP=11;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-fixed2; 	 	NAME=;		MAXSTEP=14;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

	MODEL=; 			NAME=-fh;		MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=; 			NAME=-fh;		MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-fixed; 		NAME=-fh;		MAXSTEP=11;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-fixed2; 	 	NAME=-fh;		MAXSTEP=14;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

	MODEL=; 			NAME=-dbec;		MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./model$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=; 			NAME=-dbec;		MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./model$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-fixed; 		NAME=-dbec;		MAXSTEP=11;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./model$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-fixed2; 	 	NAME=-dbec;		MAXSTEP=14;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./model$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
