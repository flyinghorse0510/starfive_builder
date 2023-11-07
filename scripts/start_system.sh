#!/bin/bash
qemu-system-riscv64 -machine virt -m 8G -nographic \
    -smp 8,sockets=1,cores=8 \
    -accel tcg \
    -kernel /usr/lib/u-boot/qemu-riscv64_smode/u-boot.bin \
    -netdev user,id=net0,hostfwd=::6722-:22 \
    -device virtio-net-device,netdev=net0 \
    -drive file=disk/main_ubuntu_22_riscv.img,format=raw,if=virtio \
    -device virtio-rng-pci