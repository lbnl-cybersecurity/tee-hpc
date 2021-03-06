#!/usr/bin/env bash

time (docker run --rm -it --device=/dev/isgx kripke-scone sh -c "OMP_NUM_THREADS=6 SCONE_HEAP=8G ./bin/kripke.exe --groups 24 --gset 1 --quad 128 --dset 128 --legendre 4 --zones 128,32,32 --procs 1,1,1") > kripke-th6 2>&1
