#!/usr/bin/env bash
benchmarks=( bfs pr cc bc sssp tc ) 

declare -a arguments=("-f benchmark/graphs/road.sg -n64" "-f benchmark/graphs/road.sg -i1000 -t1e-4 -n16" "-f benchmark/graphs/road.sg -n16" "-f benchmark/graphs/road.sg -i4 -n16" "-f benchmark/graphs/road.wsg -n64 -d50000" "-f benchmark/graphs/roadU.sg -n3")

threads=( 6 )

mkdir gapbs-out

for tr in "${threads[@]}"
do
i=0
for bm in "${benchmarks[@]}"
do
time (docker run --rm -it --device=/dev/isgx gapbs-road sh -c "OMP_NUM_THREADS=$tr SCONE_HEAP=2G ./$bm ${arguments[i]}") > gapbs-out/$bm-road-epc-th$tr.out 2>&1
i=$i+1
dmesg > temp_dmsg
tac temp_dmsg | grep -m 1 'page_swaps_ewb :' >>  gapbs-out/$bm-road-epc-th$tr.out
done
done
