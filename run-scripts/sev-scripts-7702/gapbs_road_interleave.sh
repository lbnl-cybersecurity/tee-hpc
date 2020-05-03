#!/bin/bash
export OMP_NUM_THREADS=128
time (numactl --interleave=0,1 ./bfs -f benchmark/graphs/road.sg -n64) > benchmark/out/bfs-road.out 2>&1
time (numactl --interleave=0,1 ./pr -f benchmark/graphs/road.sg -i1000 -t1e-4 -n16) > benchmark/out/pr-road.out 2>&1
time (numactl --interleave=0,1 ./cc -f benchmark/graphs/road.sg -n16) > benchmark/out/cc-road.out 2>&1
time (numactl --interleave=0,1 ./bc -f benchmark/graphs/road.sg -i4 -n16) > benchmark/out/bc-road.out 2>&1
time (numactl --interleave=0,1 ./sssp -f benchmark/graphs/road.wsg -n64 -d50000) > benchmark/out/sssp-road.out 2>&1
time (numactl --interleave=0,1 ./tc -f benchmark/graphs/roadU.sg -n3) > benchmark/out/tc-road.out 2>&1
