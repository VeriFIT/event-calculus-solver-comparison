TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=clingo-lpx --strict -n0 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-50:
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# fixed zeno

run-lpx-fixed:
	MAXSTEP=6; MAXTIME=15; ${TIME} ${LPX_CMD} ./model-fixed.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-fixed-nosig:	# works for this example
	MAXSTEP=6; MAXTIME=15; ${TIME} ${LPX_CMD} ./model-fixed.lp -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-fixed-50:
	MAXSTEP=50; MAXTIME=63; ${TIME} ${LPX_CMD} ./model-fixed.lp  | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_EFF=clingo-lpx --strict -n0 ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

#TODO#run-lpx-efficient:
#TODO#	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-fixed-efficient.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
#TODO#run-lpx-fixed-efficient:
#TODO#	MAXSTEP=6; MAXTIME=1000; ${TIME} ${LPX_CMD_FH} ./model-fixed-efficient.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	MODEL=model; 			NAME=;		MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model; 			NAME=;		MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model-fixed; 		NAME=;		MAXSTEP=6;	MAXTIME=15;		../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model-fixed; 		NAME=;		MAXSTEP=50;	MAXTIME=63;		../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

#TODO#	MODEL=model; 			NAME=-efficient;	MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
#TODO#	MODEL=model; 			NAME=-efficient;	MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
#TODO#	MODEL=model-fixed; 		NAME=-efficient;	MAXSTEP=6;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
#TODO#	MODEL=model-fixed; 		NAME=-efficient;	MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL$$NAME.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
