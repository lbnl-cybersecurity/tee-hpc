# Run Scripts Artifact


## NAS parallel benchmarks

Assuming that the npb-scone docker container exists already, run:

```
./npb_run.sh C
```

In order to collect Enclave Page Cache faults, run:

```
./npb_epc.sh C
```

## GAPBS

Assuming that the gapbs-road docker container has already been built, run:

```
./gapbs_run.sh
```

For Enclave Page Cache faults, run:

```
./gapbs_epc.sh
```

## LightGBM

Assuming that the lgbm-scone container exists, run:

```
./lgbm_run.sh
```