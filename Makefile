ifeq ($(ARCH),)
ARCH := 60
endif

targets = check_shuffle check_atomic
all: $(targets)

clean:
	rm -f $(targets)

$(targets): %: %.cu
	nvcc -gencode arch=compute_$(ARCH),code=sm_$(ARCH) $< -o $@
