TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=clingo-lpx --strict -n0 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXSTEP=7; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp ./narrative1.lp  | ../utils/replace_assignments.sh | ../utils/make-readable.sh

# takes around 50sec, need to disable last step because zeno behavior never exceeds the zeno timepoint
run-lpx-nocatch:
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp ./narrative2.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


run-lpx-nosig:	# works for this example
	MAXSTEP=7; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp ./narrative1.lp -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-nocatch-nosig:	# does not work here since last step is disabled
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp ./narrative2.lp -c disablelaststep=1 -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# fixed zeno

run-lpx-fix-flat_loss:
	MAXSTEP=7; MAXTIME=1000; ${TIME} ${LPX_CMD} ./fix-flat_loss.lp ./narrative2.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	
run-lpx-fix-min_dur:
	MAXSTEP=7; MAXTIME=1000; ${TIME} ${LPX_CMD} ./fix-min_dur.lp ./narrative2.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	

run-lpx-fix-flat_loss-nosig:	# TODO causes problems here (many models with 'e')
	MAXSTEP=7; MAXTIME=1000; ${TIME} ${LPX_CMD} ./fix-flat_loss.lp ./narrative2.lp -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	
run-lpx-fix-min_dur-nosig:	# works for this example
	MAXSTEP=7; MAXTIME=1000; ${TIME} ${LPX_CMD} ./fix-min_dur.lp ./narrative2.lp -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	

#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_EFF=clingo-lpx --strict -n0 ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

#TODO#run-lpx-eff:
#TODO#	MAXSTEP=6; ${TIME} ${LPX_CMD_EFF} ./model-efficient.lp ./narrative1.lp | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	MODEL=model; 			NAME=;		MAXSTEP=7;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp ./narrative1.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=model; 			NAME=;		MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp ./narrative2.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=fix-flat_loss; 	NAME=;		MAXSTEP=7;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp ./narrative2.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=fix-min_dur; 	 	NAME=;		MAXSTEP=7;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./$$MODEL.lp ./narrative2.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0

#TODO#	MODEL=model-efficient; MAXSTEP=6;  ../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL.lp ./narrative1.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL-s$$MAXSTEP.log ; exit 0
#TODO#	MODEL=model-efficient; MAXSTEP=50; ../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL.lp ./narrative2.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL-s$$MAXSTEP.log ; exit 0
#TODO#
#TODO#	MODEL=fix-flat_loss-efficient; MAXSTEP=6;  ../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL.lp ./narrative2.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL-s$$MAXSTEP.log ; exit 0
#TODO#	MODEL=fix-min_dur-efficient; MAXSTEP=6;  ../../scripts/maketrace.sh "${LPX_CMD_EFF} ./$$MODEL.lp ./narrative2.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx-$$MODEL-s$$MAXSTEP.log ; exit 0
