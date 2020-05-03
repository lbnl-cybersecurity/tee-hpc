#!/bin/bash 

if [ $1 != 'D' ] && [ $1 != 'C' ]
then
    echo "Expecting a npb class (C,D)"
    exit
exit
fi

bms=(bt.$1.x cg.$1.x dc.$1.x ep.$1.x ft.$1.x is.$1.x lu.$1.x mg.$1.x sp.$1.x ua.$1.x)
if [ ! -d Out_Class_$1 ]; then
mkdir -p Out_Class_$1;
fi
threads=(24)

for thread in "${threads[@]}";do

	for bm in "${bms[@]}";do
	echo $bm
	echo $thread
	export OMP_NUM_THREADS=$thread
	(time numactl --interleave=0,1,2,3 ./$bm) > Out_Class_$1/$bm-$thread 2>&1
 	done
done
