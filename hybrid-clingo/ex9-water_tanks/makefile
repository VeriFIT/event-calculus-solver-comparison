TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=clingo-lpx --strict -n0 ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME

run-lpx:
	MAXSTEP=5; MAXTIME=19; ${TIME} ${LPX_CMD} ./model.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
run-lpx-nosig:	# works for this example
	MAXSTEP=5; MAXTIME=19; ${TIME} ${LPX_CMD} ./model.lp -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-50:
	MAXSTEP=50; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# fixed zeno

run-lpx-fix:
	MAXSTEP=8; MAXTIME=22; ${TIME} ${LPX_CMD} ./model-fixed.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	
run-lpx-fix-nosig:	# works for this example
	MAXSTEP=8; MAXTIME=22; ${TIME} ${LPX_CMD} ./model-fixed.lp -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	

run-lpx-fix2:
	MAXSTEP=14; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-fixed2.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh

# currently broken
run-lpx-fix3:
	MAXSTEP=11; MAXTIME=1000; ${TIME} ${LPX_CMD} ./model-fixed3.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh
	

#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_EFF=clingo-lpx --strict -n0 ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP

#TODO#run-lpx-eff:
#TODO#	MAXSTEP=6; ${TIME} ${LPX_CMD_EFF} ./model-efficient.lp | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	MODEL=; 			NAME=;		MAXSTEP=5;	MAXTIME=19;		../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=; 			NAME=;		MAXSTEP=50;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
	MODEL=-fixed; 		NAME=;		MAXSTEP=8;	MAXTIME=22;		../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
#	MODEL=-fixed2; 	 	NAME=;		MAXSTEP=14;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
#	MODEL=-fixed3; 	 	NAME=;		MAXSTEP=14;	MAXTIME=1000;	../../scripts/maketrace.sh "${LPX_CMD} ./model$$MODEL.lp -c disablelaststep=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$MODEL$$NAME-s$$MAXSTEP.log ; exit 0
