#!/bin/bash

# Copy parsec3 source
echo "copying parsec3 source into the container"
mkdir -p /home/starfive/
cp -R /parsec3 /home/starfive/parsec3


# Enter parsec3 source directory
cd /home/starfive/parsec3 || exit
echo "source env.sh"
# source env.sh
. env.sh

# Set build target
if [ "${1}" != "all" ]; then
    export BENCHMARKS="$*"
fi
echo "set build target ==> [ ${BENCHMARKS} ]"

# Split target string as list
IFS=" "
read -ra benchmarkList <<< "${BENCHMARKS}"

echo "build target"
for benchmark in "${benchmarkList[@]}"
do
    echo "building ${benchmark}"
    sleep 2
    if [ "${benchmark}" = "raytrace" ]; then
        # raytrace static link needs some extra porting work for cmake, currently using some dirty trick
        unlink /usr/bin/g++
        unlink /usr/bin/gcc
        ln -s /usr/bin/evil_g++ /usr/bin/g++
        ln -s /usr/bin/evil_gcc /usr/bin/gcc
    else
        unlink /usr/bin/g++
        unlink /usr/bin/gcc
        ln -s /usr/bin/g++-11 /usr/bin/g++
        ln -s /usr/bin/gcc-11 /usr/bin/gcc
    fi
    export BENCHMARKS="${benchmark}"
    # Redirect stdout to clear the output
    ./bin/build | tee "${benchmark}.build_log"
done

# Create output directory
echo "create output directory"
mkdir -p /output/images
mkdir -p /output/logs

# Copy built binary files
echo "copy binary files"
rsync -a images/ /output/images

# Copy build logs
echo "copy build logs"
cp *.build_log /output/logs/