# shfl-on-pascal

This works as expected with 0 errors

    make ARCH=50
    ./check
    check: 0.0

this should not work on >Pascal

    make ARCH=60
    ./check
    check: 31.0

in a single thread all **other** 31 warp values are not seen by the warp

TODO: why

