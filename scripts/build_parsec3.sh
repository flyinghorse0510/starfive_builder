#!/bin/bash

# Copy parsec3 source
echo "Copying parsec3 source into the container"
mkdir -p /home/starfive/
cp -R /parsec3 /home/starfive/parsec3


# Enter parsec3 source directory
cd /home/starfive/parsec3
# source env.sh
. env.sh

# Set build target
if [ "${1}" != "all" ]; then
    export BENCHMARKS="$*"
fi

./bin/build

mkdir -p /output/images

rsync -a images/ /output/images