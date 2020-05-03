# Docker Files Artifact

This document explains how to build docker containers using the available docker files to eventually run
benchmarks with SGX.

## NAS parallel benchmarks

Follow the following steps to build the docker container to run NPB experiments:

```sh
cd docker-files/
wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz
tar -xzvf NPB3.3.1.tar.gz

cp npb-files/sgx-musl.conf .
cp npb-files/suite.def .
cp npb-files/make.def .
cp npb-files/setparams .

docker build -f Dockerfile-npb . -t npb-scone
```

## GAPBS

Follow these steps to build the docker container to run GAPBS with SGX:

```sh
git clone https://github.com/sbeamer/gapbs.git
cd gapbs/
git checkout ad3be9ea1b275bad46fe00573eaeb

update bench.mk file to build only road network graph
cp ../gapbs-files/bench.mk benchmark/

# build road network graphs
make bench-graphs
rm -rf benchmark/graphs/raw

cd ../

cp gapbs-files/sgx-musl.conf .

docker build -f Dockerfile-gapbs . -t gapbs-road
```

## LightGBM

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
To build the docker container:

```
cp lgbm-files/sgx-musl.conf .
cp lgbm-files/CMakeLists.txt .
cp lgbm-files/lgbm.conf .
docker build -f Dockerfile-lgbm . -t lgbm-scone
```

## Mobiliti

[Mobiliti](https://crd.lbl.gov/departments/computer-science/cag/research/mobiliti/) is not open-source, so we are not providing instructions on how to build or run the benchmark.

