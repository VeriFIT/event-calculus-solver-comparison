log-all-lpx:
	$(MAKE) -C ex1-* log-lpx
	$(MAKE) -C ex2-* log-lpx
	$(MAKE) -C ex3-* log-lpx
	$(MAKE) -C ex4-* log-lpx
	$(MAKE) -C ex5-* log-lpx
	$(MAKE) -C ex6-* log-lpx
	$(MAKE) -C ex7-* log-lpx
	$(MAKE) -C ex8-* log-lpx
	$(MAKE) -C ex9-* log-lpx
	$(MAKE) -C ex10-* log-lpx
	$(MAKE) -C ex11-* log-lpx
	$(MAKE) -C ex12-* log-lpx
	$(MAKE) -C ex13-* log-lpx
	$(MAKE) -C ex14-* log-lpx

log-all-con:
	$(MAKE) -C ex1-* log-con
	$(MAKE) -C ex2-* log-con
	$(MAKE) -C ex3-* log-con
	$(MAKE) -C ex4-* log-con
	$(MAKE) -C ex5-* log-con
	$(MAKE) -C ex6-* log-con
	$(MAKE) -C ex7-* log-con
	$(MAKE) -C ex8-* log-con
	$(MAKE) -C ex9-* log-con
	$(MAKE) -C ex10-* log-con
	$(MAKE) -C ex11-* log-con
	$(MAKE) -C ex12-* log-con
	$(MAKE) -C ex13-* log-con
	$(MAKE) -C ex14-* log-con

log-all-con-parallel:
	$(MAKE) -C ex1-* log-lpx &
	$(MAKE) -C ex2-* log-lpx &
	$(MAKE) -C ex3-* log-lpx &
	$(MAKE) -C ex4-* log-lpx &
	$(MAKE) -C ex5-* log-lpx &
	$(MAKE) -C ex6-* log-lpx &
	$(MAKE) -C ex7-* log-lpx &
	$(MAKE) -C ex8-* log-lpx &
	$(MAKE) -C ex9-* log-lpx &
	$(MAKE) -C ex10-* log-lpx &
	$(MAKE) -C ex11-* log-lpx &
	$(MAKE) -C ex12-* log-lpx &
	$(MAKE) -C ex13-* log-lpx &
	$(MAKE) -C ex14-* log-lpx &
	@true

log-all-con-parallel:
	$(MAKE) -C ex1-* log-con &
	$(MAKE) -C ex2-* log-con &
	$(MAKE) -C ex3-* log-con &
	$(MAKE) -C ex4-* log-con &
	$(MAKE) -C ex5-* log-con &
	$(MAKE) -C ex6-* log-con &
	$(MAKE) -C ex7-* log-con &
	$(MAKE) -C ex8-* log-con &
	$(MAKE) -C ex9-* log-con &
	$(MAKE) -C ex10-* log-con &
	$(MAKE) -C ex11-* log-con &
	$(MAKE) -C ex12-* log-con &
	$(MAKE) -C ex13-* log-con &
	$(MAKE) -C ex14-* log-con &
	@true

# both clingcon and clingo-lpx 13
create-env-clingcon:
	conda env create -f ./utils/clingcon_env.yml || \
	conda env update -f ./utils/clingcon_env.yml

# clingo-lpx 14
create-env-newlpx:
	conda create -n clingo-lpx -c potassco/label/dev-20 -c conda-forge clingo-lpx
#	conda env create -f ./utils/clingo_lpx_env.yml || \
#	conda env update -f ./utils/clingo_lpx_env.yml

activate-fdec-env:
	@echo "run this manually: conda activate fdec"
activate-clingo-newlpx-env:
	@echo "run this manually: conda activate clingo-lpx"

build-format_output:
	$(MAKE) -C ./utils/format-output/
