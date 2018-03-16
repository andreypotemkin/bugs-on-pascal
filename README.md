# Bugs on Pascal

The same code compiled to support Maxwell and Pascal architectures provides different results on Pascal-machine.
This strange behaviour is connected with use of shuffle and atomic operations.

## Check of shuffle operation:
This test works on Pascal-machine as expected without errors in case of Maxwell-supported compilation:

    make ARCH=50
    ./check_shuffle
    computed 0.0, while true is 0.0

However, it fails in case of Pascal-supported compilation:

    make ARCH=60
    ./check_shuffle
    computed 31.0, while true is 0.0

The latter can be explained by the presence of shuffle operation inside warp-divergent condition. Assumptions that work on Kepler and Maxwell architectures
don't hold on Pascal architecture. It is interested to note that Nvidia garanties normal (expected) behaviour of the same code on Volta-machines.

## Check of atomic operation:

This test fails on Pascal-machine in case of Maxwell-supported compilation:
    make ARCH=50
    ./check_atomic
    computed 0.0, while true is 32.0

However, it works as expected in case of Pascal-supported compilation:

    make ARCH=60
    ./check_atomic
    computed 32.0, while true is 32.0
    
I don't know how to explain it. It seems to be a bug of nvcc compiler.

