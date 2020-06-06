# Results Data Artifact

The files in this folder contain the execution times of the experiments discussed in the paper.

- sgx_time.csv contains the native and SGX execution time (6 execution threads) on Intel i7-8700 system.
- time_sev_7401P.csv contains the native, QEMU and QEMU+SEV execution time for default and interleaved memory allocation policies (24 execution threads) on AMD EPYC-7401P system.
- time_sev_7702.csv contains the native, QEMU and QEMU+SEV execution time for default and interleaved memory allocation policies (128 execution threads) on AMD EPYC-7702 system.
- time_sev_7402P.csv contains some initial data for native, QEMU and QEMU+SEV execution time for default memory allocation policy (24 execution threads) on AMD EPCY-7402P system (single NUMA node system, so no interleaved memory allocation). 

**Note:** All of these times are in seconds. 
