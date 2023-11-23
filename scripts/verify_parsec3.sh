#!/bin/bash

# Copy parsec3 binaries
echo "copying parsec3 binaries"
rm -rf vImages/
cp -R images vImages

# Enter parsec3 binary directory
pushd vImages || exit 1

benchmarkList=("blackscholes" "bodytrack" "canneal" "dedup" "facesim" "ferret" "fluidanimate" "freqmine" "raytrace" "streamcluster" "swaptions" "vips" "x264")
simsizeList=("simmedium" "simsmall" "simlarge")
threadList=("1" "2" "3" "4" "5" "6" "7" "8")

for simsize in "${simsizeList[@]}"
do
    for benchmark in "${benchmarkList[@]}"
    do
        for thread in "${threadList[@]}"
        do
            echo "=================="
            echo "running ${benchmark} with ${simsize}, ${thread} threads used"
            echo ">>>>>>>>>>>>>>>>>>"
            pushd "${benchmark}"/"${simsize}" || exit 1
            date
            ./run.sh "${thread}" 1>stdout_${benchmark}_${simsize}_${thread}.log 2>stderr_${benchmark}_${simsize}_${thread}.log
            date
            popd || exit 1
            echo "=================="
        done
    done
done

popd || exit 1
# clean up
rm -rf vImages/
echo "VERIFICATION PASSED!"