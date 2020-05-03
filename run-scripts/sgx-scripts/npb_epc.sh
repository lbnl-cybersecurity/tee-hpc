#!/bin/bash 

if [ $1 != 'A' ] && [ $1 != 'B' ] && [ $1 != 'C' ]
then
    echo "Expecting a npb class (A,B,C)"
    exit
fi

bms=(bt.$1.x cg.$1.x dc.$1.x ep.$1.x ft.$1.x is.$1.x lu.$1.x mg.$1.x sp.$1.x ua.$1.x)
if [ ! -d Class_$1_npb ]; then
	  mkdir -p Class_$1_npb;
fi
  
threads=( 1 2 4 6 )
for tr in "${threads[@]}"
do
for bm in "${bms[@]}"
do
echo $bm
(docker run --rm -it --device=/dev/isgx npb-scone sh -c "OMP_NUM_THREADS=$tr SCONE_HEAP=1G bin/$bm" ) > Class_$1_npb/Out_$bm-th$tr 2>&1
dmesg > temp_dmsg
tac temp_dmsg | grep -m 1 'page_swaps_ewb :' >>  Class_$1_npb/Out_epc_$bm-th$tr
done
done
