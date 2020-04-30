# SGX Driver Patch Artifact

This directory contains a small patch that is needed to modify the SGX driver to print the number of 
Enclave Page Cache (EPC) faults in kernel message buffer, which is eventually used by the scripts to collect EPC fault numbers when running a workload. 

To get the linux sgx driver:

```
git clone https://github.com/intel/linux-sgx-driver.git
cd linux-sgx-driver
git checkout 778dd1f711359cdabe4e1ca8
```
Apply the patch and build the driver:

```
git apply ../0001-Modify-the-driver-to-print-EPC-faults.patch
make
```

Install the driver and start aesmd service:

```
sudo cp isgx.ko "/lib/modules/"`uname -r`"/kernel/drivers/intel/sgx"
sudo sh -c "cat /etc/modules | grep -Fxq isgx || echo isgx >> /etc/modules"
sudo cp isgx.ko /lib/modules/"`uname -r`"
sudo /sbin/depmod
sudo /sbin/modprobe isgx
sudo service aesmd start
```