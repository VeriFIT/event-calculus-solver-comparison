TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"


#-----------------------------------------------------------------------------------------------------------------------
# base
LPX_CMD=python ../fdec-incr.py --maxtime $$MAXTIME -c paramHeight=$$HEIGHT ./model.lp
#LPX_CMD=python -m clingolpx --enable-python --strict -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME -c paramHeight=$$HEIGHT
CON_CMD=python ../fdec-incr.py --maxtime $$MAXTIME --con -c paramHeight=$$HEIGHT ./model.lp
#CON_CMD=python -m clingcon --enable-python -n10 ./model.lp ../axioms/fdec.lp ../axioms/fdec-show.lp -c maxstep=$$MAXSTEP -c maxtime=$$MAXTIME -c paramHeight=$$HEIGHT

run-lpx:
	MAXTIME=1000; HEIGHT=20; ${TIME} ${LPX_CMD}
run-lpx-nosig:
	MAXTIME=1000; HEIGHT=20; ${TIME} ${LPX_CMD} --no_signifstep

run-lpx-queries:
	MAXTIME=1000; HEIGHT=20; ${TIME} ${LPX_CMD} ./extra-queries.lp
run-lpx-queries-nosig:
	MAXTIME=1000; HEIGHT=20; ${TIME} ${LPX_CMD} ./extra-queries.lp --no_signifstep


run-con:
	MAXTIME=1000; HEIGHT=20; ${TIME} ${CON_CMD}
run-con-nosig:
	MAXTIME=1000; HEIGHT=20; ${TIME} ${CON_CMD} --no_signifstep

run-con-queries:
	MAXTIME=1000; HEIGHT=20; ${TIME} ${CON_CMD} ./extra-queries.lp
run-con-queries-nosig:
	MAXTIME=1000; HEIGHT=20; ${TIME} ${CON_CMD} ./extra-queries.lp --no_signifstep

#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log-lpx:
	@mkdir -p ./logs ; rm -f ./logs/lpx*.log
	NAME=; 		MAXTIME=1000;	HEIGHT=20;	../../scripts/maketrace.sh "${LPX_CMD}" ./logs/lpx$$NAME-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXTIME=1000;	HEIGHT=40;	../../scripts/maketrace.sh "${LPX_CMD}" ./logs/lpx$$NAME-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXTIME=1000;	HEIGHT=80;	../../scripts/maketrace.sh "${LPX_CMD}" ./logs/lpx$$NAME-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXTIME=1000;	HEIGHT=160; ../../scripts/maketrace.sh "${LPX_CMD}" ./logs/lpx$$NAME-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXTIME=1000;	HEIGHT=320; ../../scripts/maketrace.sh "${LPX_CMD}" ./logs/lpx$$NAME-h$$HEIGHT.log ; exit 0
	NAME=-hit; 	MAXTIME=1000; 	HEIGHT=4;   ../../scripts/maketrace.sh "${LPX_CMD}" ./logs/lpx$$NAME-h$$HEIGHT.log ; exit 0
	NAME=-miss;	MAXTIME=1000; 	HEIGHT=3;   ../../scripts/maketrace.sh "${LPX_CMD}" ./logs/lpx$$NAME-h$$HEIGHT.log ; exit 0
	
	NAME=-queries;	MAXTIME=1000;	HEIGHT=20;	../../scripts/maketrace.sh "${LPX_CMD} ./extra-queries.lp" ./logs/lpx$$NAME-h$$HEIGHT.log ; exit 0

log-con:
	@mkdir -p ./logs ; rm -f ./logs/con*.log
	NAME=; 		MAXTIME=1000;	HEIGHT=20;	../../scripts/maketrace.sh "${CON_CMD}" ./logs/con$$NAME-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXTIME=1000;	HEIGHT=40;	../../scripts/maketrace.sh "${CON_CMD}" ./logs/con$$NAME-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXTIME=1000;	HEIGHT=80;	../../scripts/maketrace.sh "${CON_CMD}" ./logs/con$$NAME-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXTIME=1000;	HEIGHT=160; ../../scripts/maketrace.sh "${CON_CMD}" ./logs/con$$NAME-h$$HEIGHT.log ; exit 0
	NAME=; 		MAXTIME=1000;	HEIGHT=320; ../../scripts/maketrace.sh "${CON_CMD}" ./logs/con$$NAME-h$$HEIGHT.log ; exit 0
	NAME=-hit; 	MAXTIME=1000; 	HEIGHT=4;   ../../scripts/maketrace.sh "${CON_CMD}" ./logs/con$$NAME-h$$HEIGHT.log ; exit 0
	NAME=-miss;	MAXTIME=1000; 	HEIGHT=3;   ../../scripts/maketrace.sh "${CON_CMD} --maxstep 5" ./logs/con$$NAME-h$$HEIGHT.log ; exit 0

	NAME=-queries;	MAXTIME=1000;	HEIGHT=20;	../../scripts/maketrace.sh "${CON_CMD} ./extra-queries.lp" ./logs/con$$NAME-h$$HEIGHT.log ; exit 0
