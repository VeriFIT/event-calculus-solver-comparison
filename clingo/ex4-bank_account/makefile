TIME=/usr/bin/time -f "\n  real      %E\n  real [s]  %e\n  user [s]  %U\n  sys  [s]  %S\n  mem  [KB] %M\n  avgm [KB] %K"

#AXIOMS=../axioms/bec_clingo.lp
#AXIOMS=../axioms/dbec_clingo.lp
AXIOMS=../axioms/dec_clingo.lp ../axioms/dec_clingo-show.lp
#AXIOMS=../axioms/ec_clingo.lp

#-----------------------------------------------------------------------------------------------------------------------
# base

CMD=clingo -c maxtime=$$MAXTIME -c maxmoney=$$MAXMONEY -n 0 ${AXIOMS} ./model.lp
run:
	MAXTIME=10; MAXMONEY=20; ${TIME} ${CMD}


#-----------------------------------------------------------------------------------------------------------------------
# alternatives (fixes / improvements)


#-----------------------------------------------------------------------------------------------------------------------
# log the execution

log:
	MAXTIME=10;  MAXMONEY=20;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-m$$MAXMONEY.log ; exit 0
	MAXTIME=20;  MAXMONEY=20;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-m$$MAXMONEY.log ; exit 0
	MAXTIME=40;  MAXMONEY=20;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-m$$MAXMONEY.log ; exit 0
	MAXTIME=80;  MAXMONEY=20;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-m$$MAXMONEY.log ; exit 0
	MAXTIME=160; MAXMONEY=20;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-m$$MAXMONEY.log ; exit 0
	MAXTIME=320; MAXMONEY=20;  ../../scripts/maketrace.sh "${CMD}" ./logs/t$$MAXTIME-m$$MAXMONEY.log ; exit 0
