# tee-hpc

This repository provides artifacts and instructions to use them to perform experiments for the analysis of 
Trusted Execution Environments (SGX and SEV) for Secure High Performance Computing.




## Intel SGX Setup
Intel SGX experiments are performed on an Intel i7-8700 machine.
Since, we use SCONE to run SGX experiments there is no need to install the SGX SDK.

Assuming that SGX is enabled in BIOS (look [here](https://github.com/intel/sgx-software-enable) for instructions, if it is not), the next thing is to install the SGX driver. 

The instructions given [here](intel-sgx-driver-patch/README.md) can be followed to do that.

To run the SGX experiments:

Follow these [instructions](docker-files/README.md) to build docker containers for SGX experiments and these [instructions](run-scripts/README.md) to run experiments using the built containers.  
 
## AMD SEV Setup
AMD SEV experiments are performed on EPYC-7401P and EPYC-7702 systems.
Following instructions can be followed on both systems to set-up the systems to run SEV experiments:

Install few packages that will be needed for the set-up:

```
apt-get install git flex apt-utils xfce4 xfce4-goodies tightvncserver
```

We use one of the latest linux kernels (5.4.1) with SEV support to run our experiments. 
Follow the instructions provided in this [link](https://www.cyberciti.biz/tips/compiling-linux-kernel-26.html) to update the kernel to 5.4.1.

Next, download the official source material for AMD SEV setup and run the provide build script:

```
git clone --single-branch -b master https://github.com/AMDESE/AMDSEV.git
cd AMDSEV/distros/ubuntu-18.04
./build.sh
```

This should install required drivers and enable SEV, which can be confirmed using

```
ls -l /dev/sev
```

Next, we need to create a VM which will be used to run benchmarks under SEV.
Follow the following instructions:

The first step is to create a disk image using qemu-image:

```sh
qemu-img create -f qcow2 ubuntu-18.04.qcow2 30G
```

Next, create a copy of OVMF_VARS.fd which is a "template" used to emulate persistent NVRAM storage (which is needed by each VM)

```sh
cp /usr/local/share/qemu/OVMF_VARS.fd OVMF_VARS.fd
```

Next, download a ubuntu image of your choice from [here](http://releases.ubuntu.com/18.04/).
We use server edition of ubuntu 18.04:

```sh
wget http://releases.ubuntu.com/18.04/ubuntu-18.04.4-live-server-amd64.iso
```

To install this ubuntu image on the created disk, we need to set up a vnc connection (if this process is performed on a remote server), since ubuntu installer works in graphic mode.

```sh
ssh -L 5900+[X]:localhost:5900+X root@[packet server ip address]
```

Then run:

```sh
launch-qemu.sh -hda ubuntu-18.04.qcow2 -cdrom ubuntu-18.04.4-live-server-amd64.iso -vnc [X] -nosev -console serial

Where, X = Port number to be used - 5900
```
Follow the instructions there to install ubuntu on the disk image (ubuntu-18.04.qcow2), which will be later used to run guest VM.

## SGX and SEV Experiments

To run the benchmarks for both SGX and SEV systems, follow the instructions in run-scripts/README.md.