#!/usr/bin/env bash

time (docker run --rm -it --device=/dev/isgx lulesh-scone sh -c "OMP_NUM_THREADS=6 SCONE_HEAP=256M ./lulesh2.0 -s 48") > lulesh-th6 2>&1
