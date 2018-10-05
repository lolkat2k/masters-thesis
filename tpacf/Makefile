FUT_CL = /home/fjc657/futhark/.stack-work/install/x86_64-linux/lts-12.7/8.4.3/bin/futhark-opencl
RUNS = 2

.PHONY: benchmark

all: benchmark

benchmark: tpacf tpacf-genred-v1 tpacf-genred-v2

tpacf: tpacf.fut
	@futhark-bench --compiler=$(FUT_CL) --runs=$(RUNS) $<

tpacf-genred-v1: tpacf-genred-v1.fut
	@futhark-bench --compiler=$(FUT_CL) --runs=$(RUNS) $<

tpacf-genred-v2: tpacf-genred-v2.fut
	@futhark-bench --compiler=$(FUT_CL) --runs=$(RUNS) $<

clean:
	rm -f tpacf tpacf-genred-v1 tpacf-genred-v2
	rm -f *.c
