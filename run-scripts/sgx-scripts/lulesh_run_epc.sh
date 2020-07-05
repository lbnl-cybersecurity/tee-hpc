#!/usr/bin/env bash

time (docker run --rm -it --device=/dev/isgx lulesh-scone sh -c "OMP_NUM_THREADS=6 SCONE_HEAP=2G  ./lulesh2.0 -s 48") > lulesh-th6-epc 2>&1
dmesg > temp_dmsg
tac temp_dmsg | grep -m 1 'page_swaps_ewb :' >>  lulesh-th6-epc
