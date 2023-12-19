#!/bin/bash

# Clone the source
mkdir -p src
git clone https://github.com/flyinghorse0510/parsec-starfive.git --depth 1 --recursive --shallow-submodules src/parsec3

# pull the lfs (input data) of parsec3
cd src/parsec3 || exit
git lfs pull

# get inputs
./get-inputs
