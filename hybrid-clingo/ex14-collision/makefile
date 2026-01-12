TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=python -m clingolpx --enable-python --strict -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME -c paramHeight=$$HEIGHT
CON_CMD=python -m clingcon --enable-python -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME -c paramHeight=$$HEIGHT

run-lpx:
	MAXSTEP=3; MAXTIME=1000; HEIGHT=20; ${TIME} ${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh

run-lpx-nosig:	# works for this example
	MAXSTEP=3; MAXTIME=1000; HEIGHT=20; ${TIME} ${LPX_CMD} -c disablesignificantconstr=1 | ../utils/replace_assignments.sh | ../utils/make-readable.sh


run-con:
	MAXSTEP=3; MAXTIME=1000; HEIGHT=20; ${TIME} ${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# other versions
LPX_CMD_EFF=python -m clingolpx --enable-python --strict -n10 ./model-efficient.lp ../axioms/clingo_lpx-efficient.lp -c maxstep=$$MAXSTEP -c paramHeight=$$HEIGHT

run-lpx-queries-tdur:
	MAXSTEP=6; MAXTIME=1000; HEIGHT=20; ${TIME} ${LPX_CMD} ./extra-queries.lp | ../utils/replace_assignments.sh | ../utils/make-readable.sh


run-lpx-eff:
	MAXSTEP=2; HEIGHT=20; ${TIME} ${LPX_CMD_EFF} | ../utils/make-readable.sh


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	@mkdir -p ./logs ; rm -f ./logs/*.log
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=20;	../../scripts/maketrace.sh "${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=40;	../../scripts/maketrace.sh "${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=80;	../../scripts/maketrace.sh "${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=160; ../../scripts/maketrace.sh "${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=320; ../../scripts/maketrace.sh "${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=-hit; 	MAXSTEP=3;	MAXTIME=1000; 	HEIGHT=4;   ../../scripts/maketrace.sh "${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=-miss;	MAXSTEP=3;	MAXTIME=1000; 	HEIGHT=3;   ../../scripts/maketrace.sh "${LPX_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/lpx$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=20;	../../scripts/maketrace.sh "${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=40;	../../scripts/maketrace.sh "${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=80;	../../scripts/maketrace.sh "${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=160; ../../scripts/maketrace.sh "${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXSTEP=3;	MAXTIME=1000;	HEIGHT=320; ../../scripts/maketrace.sh "${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=-hit; 	MAXSTEP=3;	MAXTIME=1000; 	HEIGHT=4;   ../../scripts/maketrace.sh "${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
	NAME=-miss;	MAXSTEP=3;	MAXTIME=1000; 	HEIGHT=3;   ../../scripts/maketrace.sh "${CON_CMD} | ../utils/replace_assignments.sh | ../utils/make-readable.sh" ./logs/con$$NAME-s$$MAXSTEP-h$$HEIGHT.log ; exit 0
