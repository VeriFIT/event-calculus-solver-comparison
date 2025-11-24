TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=clingo-lpx --strict -n0 ../axioms/fdec.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME
LPX_CMD_FH=clingo-lpx --strict -n0 ../axioms/fdec-ffholds.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-50:
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-fh:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-fh-50:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# fixed zeno

run-lpx-fixed:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-fixed.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-fixed-50:
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-fixed.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-fixed-fh:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-fixed.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-fixed-fh-50:
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-fixed.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_DBEC=clingo-lpx --strict -n0 ../axioms/dbec-clingo_lpx-choice.lp -c maxstep=$$MAXSTEP
LPX_CMD_EFF=clingo-lpx --strict -n0 ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

run-lpx-dbec:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-dbec.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-fixed-dbec:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-dbec.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

#TODO#run-lpx-efficient:
#TODO#	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-fixed-efficient.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
#TODO#run-lpx-fixed-efficient:
#TODO#	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-fixed-efficient.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	MODEL=model; 			NAME=;		MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model; 			NAME=;		MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model-fixed; 		NAME=;		MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model-fixed; 		NAME=;		MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

	MODEL=model; 			NAME=-fh;	MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model; 			NAME=-fh;	MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model-fixed; 		NAME=-fh;	MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model-fixed; 		NAME=-fh;	MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_FH} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

	MODEL=model; 			NAME=-dbec;	MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model; 			NAME=-dbec;	MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model-fixed; 		NAME=-dbec;	MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model-fixed; 		NAME=-dbec;	MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_DBEC} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

#TODO#	MODEL=model; 			NAME=-efficient;	MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
#TODO#	MODEL=model; 			NAME=-efficient;	MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
#TODO#	MODEL=model-fixed; 		NAME=-efficient;	MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
#TODO#	MODEL=model-fixed; 		NAME=-efficient;	MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
