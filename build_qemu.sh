#!/bin/bash
git clone https://github.com/flyinghorse0510/qemu.git -b starfive_mem_trace --depth 1 --recursive --shallow-submodules
cd qemu || exit
mkdir -p build
cd build || exit
../configure --enable-slirp --target-list=riscv64-softmmu,riscv64-linux-user --static --disable-gio --disable-tools --disable-opengl
../configure --enable-slirp --target-list=riscv64-softmmu,riscv64-linux-user
../configure --target-list=riscv64-linux-user --static --disable-tools