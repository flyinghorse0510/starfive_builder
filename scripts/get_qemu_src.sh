#!/bin/bash
mkdir -p src
# rm -rf src/qemu
git clone https://github.com/flyinghorse0510/qemu.git -b starfive_mem_trace --depth 1 --recursive --shallow-submodules src/qemu