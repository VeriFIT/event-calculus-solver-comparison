log-all:
	$(MAKE) -C clingo log-all &
	$(MAKE) -C hybrid-clingo log-all-con &
	$(MAKE) -C hybrid-clingo log-all-lpx &
	$(MAKE) -C scasp log-all &
	$(MAKE) -C ex2asp-examples log

log-all-parallel:
	$(MAKE) -C clingo log-all-parallel &
	$(MAKE) -C hybrid-clingo log-all-parallel &
	$(MAKE) -C hybrid-clingo log-all-parallel &
	$(MAKE) -C scasp log-all-parallel &
	$(MAKE) -C ex2asp-examples log
