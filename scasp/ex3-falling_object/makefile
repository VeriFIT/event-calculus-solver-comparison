TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"

#-----------------------------------------------------------------------------------------------------------------------
# base

SETUP=echo "max_time($$MAXTIME).\ninitHeight($$HEIGHT)." > ./.maxtime_height.tmp
CMD=scasp -s0 --ec ../axioms/bec_scasp.pl ./model.pl ./.maxtime_height.tmp ../utils/cache.pl
run:
	MAXTIME=15; HEIGHT=20; ${SETUP}; ${TIME} ${CMD}
	@rm -f ./.maxtime_height.tmp


#-----------------------------------------------------------------------------------------------------------------------
# alternatives (fixes / improvements)

# demonstration of "missing the ground" --> works fine in scasp (half step)
run-miss_ground:
	MAXTIME=5; HEIGHT=4; ${SETUP}; ${TIME} ${CMD}		# this is fine
	MAXTIME=4; HEIGHT=3; ${SETUP}; ${TIME} ${CMD}		# this is fine too in scasp

#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	MAXTIME=15;  HEIGHT=20;	 ${SETUP}; ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-h$$HEIGHT.log
	MAXTIME=25;  HEIGHT=40;	 ${SETUP}; ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-h$$HEIGHT.log
	MAXTIME=45;  HEIGHT=80;	 ${SETUP}; ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-h$$HEIGHT.log
	MAXTIME=85;  HEIGHT=160; ${SETUP}; ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-h$$HEIGHT.log
	MAXTIME=165; HEIGHT=320; ${SETUP}; ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-h$$HEIGHT.log

	MAXTIME=5;   HEIGHT=4;   ${SETUP}; ../../scripts/maketrace.sh "${CMD}" ./logs/miss_ground-ok-t$$MAXTIME-h$$HEIGHT.log
	MAXTIME=4;   HEIGHT=3;   ${SETUP}; ../../scripts/maketrace.sh "${CMD}" ./logs/miss_ground-miss-t$$MAXTIME-h$$HEIGHT.log
	
	@rm -f ./.maxtime_height.tmp
