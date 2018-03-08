ifeq ($(ARCH),)
ARCH := 50
endif
abc=all

all:
	nvcc -gencode arch=compute_$(ARCH),code=sm_$(ARCH) check.cu -o check

test:
	@if [ `echo xxx` == $(abc) ]; then echo hi; fi;
