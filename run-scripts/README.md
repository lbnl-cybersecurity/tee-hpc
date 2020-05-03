# Run Scripts Artifact

## SGX Experiments 

The needed scripts to run SGX experiments on Intel system are available [here](sgx-scripts/).

### NAS parallel benchmarks

Assuming that the npb-scone docker container exists already, run:

```
./npb_run.sh C
```

In order to collect Enclave Page Cache faults, run:

```
./npb_epc.sh C
```

### GAPBS

Assuming that the gapbs-road docker container has already been built, run:

```
./gapbs_run.sh
```

For Enclave Page Cache faults, run:

```
./gapbs_epc.sh
```

### LightGBM

Assuming that the lgbm-scone container exists, run:

```
./lgbm_run.sh
```

## SEV Experiments

### NAS parallel benchmarks (Native Case)

To build the NAS parallel benchmarks, follow following instructions:

```sh
wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz
tar -xzvf NPB3.3.1.tar.gz

cp sev-files/suite.def NPB3.3.1/NPB3.3-OMP/config/suite.def
cp sev-files/make.def  NPB3.3.1/NPB3.3-OMP/config/make.def

cd NPB3.3.1/NPB3.3-OMP/
make suite
```

Then to run these benchmarks on AMD 7401P system, copy sev-scripts-7401P/npb.sh and sev-scripts-7401P/npb_interleave.sh to NPB3.3.1/NPB3.3-OMP/bin/ and do the following:

```sh
cd bin/
./npb.sh (for default memory allocation)

./npb_interleave.sh (for interleaved memory allocation)
```

For experiments on AMD 7702 system, use the scripts from sev-scripts-7702/ instead of sev-scripts-7401P/.

### NAS parallel benchmarks (QEMU and QEMU+SEV Cases)

For QEMU and QEMU+SEV cases we need to follow the same instructions as above, but inside the VM.

To run the VM, do the following, for default memory allocation:

```sh
launch-qemu.sh -hda ubuntu-18.04.qcow2 -vnc 0 -nosev -console serial -smp 24 -mem 16384
```

For interleaved memory allocation, do the following:

```sh
numactl --interleave=0,1,2,3 launch-qemu.sh -hda ubuntu-18.04.qcow2 -vnc 0 -nosev -console serial -smp 24 -mem 16384
```

`launch-qemu.sh` will be automatically installed when AMD SEV setup instructions are run as discussed in main [README](../README.md).

Once the VM is launched, npb.sh can be used to collect data for NPB benchmarks in both cases of memory allocation since, VM is launched with `numactl` call for the case of interleaved allocation.

**Note**: Remove the `-nosev` option above to launch VM for **QEMU+SEV** case. Using the above commands a vnc connection on port 5900 needs to be established to view the VM console. Moreover, the above commands launch a VM with 16G of memory and 24 cores.


### GAPBS (Native Case)

Follow the following steps to build the workloads first: 

```sh
git clone https://github.com/sbeamer/gapbs.git
cd gapbs/
git checkout ad3be9ea1b275bad46fe00573eaeb

# update bench.mk file to build only road network graph
cp ../sev-files/bench.mk benchmark/
make bench-graphs
rm -rf benchmark/graphs/raw
make
```

Now, to run the benchmarks, do the following:

```sh
cd bin/
./gapbs_road.sh (for default memory allocation)

./gapbs_road_interleave.sh (for interleaved memory allocation)
```

These scripts are available in sev-scripts-7401P (for AMD 7401P) and sev-scripts-7702 (for AMD 7702) .

### GAPBS (QEMU and QEMU+SEV Cases)

For the QEMU and QEMU+SEV Cases, we need to repeat the same instructions as for the native case inside a VM.
To launch the VM, you can follow the same process as was done [above](#NAS-parallel-benchmarks-(QEMU-and-QEMU+SEV-Cases)) for NAS parallel benchmarks.


### LightGBM (Native Case)

To build LightGBM, follow these instructions:

Download the LightGBM source:

```
git clone https://github.com/guolinke/boosting_tree_benchmarks.git
cd boosting_tree_benchmarks/
git checkout 290c349596dfdaf241a0e
```

Download and process the data-set:

```
cd boosting_tree_benchmarks/data/
```

Download the MSLR-WEB10K data set from [here](https://www.microsoft.com/en-us/research/project/mslr/).

```
unzip MSLR-WEB10K.zip
cp Fold1/train.txt .
cp Fold1/test.txt .
python msltr2libsvm.py 
```

cd ../
cp ../sev-files/CMakeLists.txt lightgbm/LightGBM/CMakeLists.txt
```

Next,

``sh
cd 
./build.sh
```

Before running the workload we need to copy the appropriate config file.

For AMD 7401P:

```sh
cp ../sev-files/lightgbm_7401P.conf lightgbm/lgbm.conf
```

And for AMD 7702:

```sh
cp ../sev-files/lightgbm_7702.conf lightgbm/lgbm.conf
```

Now, run the benchmark:

```sh
cd lightgbm
./lgbm_normal.sh
```
or 

```sh
cd lightgbm
./lgbm_interleave.sh
```

These scripts are available in sev-scripts-7401P (for AMD 7401P) and sev-scripts-7702 (for AMD 7702).

### LightGBM (QEMU and QEMU+SEV Cases)

For the QEMU and QEMU+SEV cases, we need to repeat the same instructions as for the native case inside a VM.
To launch the VM, you can follow the same process as was done [above](#NAS-parallel-benchmarks-(QEMU-and-QEMU+SEV-Cases)) for NAS parallel benchmarks.


### BLASTN (Native Case)


To download the workload follow the following instructions:

```sh
wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.7.1/ncbi-blast-2.7.1+-src.tar.gz
tar -xzvf ncbi-blast-2.7.1+-src.tar.gz
```

To compile it:

```sh
cd ncbi-blast-2.7.1+-src/c++
./configure
cd ReleaseMT/build
make all_r
```

Download the raw database and prepare it to be used by BLASTN:

```sh
wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz
gunzip nt.gz

Make the DB (this process can take several minutes):
ncbi-blast-2.7.1+-src/c++/ReleaseMT/bin/makeblastdb -in nt -dbtype nucl
```

Install blastn:

```sh
cp ncbi-blast-2.7.1+-src/c++/ReleaseMT/bin/blastn /usr/bin/blastn
```

Place the sev-files/scaffolds.trim.shred.fasta, where nt database is extracted and do
the following to run the benchmark.

For default memory allocation:

```sh
run_blast.sh
```

For interleaved memory allocation:

```sh
run_blast_interleave.sh
```

These scripts are available in sev-scripts-7401P/.


### BLASTN (QEMU and QEMU+SEV Cases)

For the QEMU and QEMU+SEV cases, we need to repeat the same instructions as for the native case inside a VM.
To launch the VM, you can follow the same process as was done [above](#NAS-parallel-benchmarks-(QEMU-and-QEMU+SEV-Cases)) for NAS parallel benchmarks.