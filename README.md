# Starfive Builder Container
Currently several docker container images have been built and uploaded to Dockerhub(flyinghorse0510):

1. `flyinghorse0510/qemu-gem5-builder`: environment for compiling QEMU and Gem5; `linux/amd64` only
2. `flyinghorse0510/multiarch-riscv64`: setting up `binfmt_misc` in kernel for run `riscv64` version executables directly; `linux/amd64` only
3. `flyinghorse0510/starfive-ubuntu`: minimal Ubuntu container with `ssh server` support and `starfive` user (username: `starfive`, passwd: `starfive`); both `linux/amd64` and `linux/riscv64`
4. `flyinghorse0510/parsec3-builder`: environment for compiling PARSEC3 benchmark suite; both `linux/amd64` and `linux/riscv64`