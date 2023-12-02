#!/bin/bash

currentWorkingDir="$(pwd)"
currentPython=${currentWorkingDir}/python3.10/bin/python3

echo "**************************"
echo "Running BLAS Basic Test"
echo "**************************"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>"
pushd blas_test/blas || exit 1
echo "[1/12] ./xblat1s > sblat1.out"
./xblat1s > sblat1.out
echo "[2/12] ./xblat1d > dblat1.out"
./xblat1d > dblat1.out
echo "[3/12] ./xblat1c > cblat1.out"
./xblat1c > cblat1.out
echo "[4/12] ./xblat1z > zblat1.out"
./xblat1z > zblat1.out
echo "[5/12] ./xblat2s < sblat2.in"
./xblat2s < sblat2.in
echo "[6/12] ./xblat2d < dblat2.in"
./xblat2d < dblat2.in
echo "[7/12] ./xblat2c < cblat2.in"
./xblat2c < cblat2.in
echo "[8/12] ./xblat2z < zblat2.in"
./xblat2z < zblat2.in
echo "[9/12] ./xblat3s < sblat3.in"
./xblat3s < sblat3.in
echo "[10/12] ./xblat3d < dblat3.in"
./xblat3d < dblat3.in
echo "[11/12] ./xblat3c < cblat3.in"
./xblat3c < cblat3.in
echo "[12/12] ./xblat3z < zblat3.in"
./xblat3z < zblat3.in
cat *.out | tee "${currentWorkingDir}"/blas_basic.log
popd || exit 1
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<"

echo "**************************"
echo "Running LAPACK Basic Test"
echo "**************************"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>"
pushd blas_test/lapack_single || exit 1
./testlsame | tee "${currentWorkingDir}"/lapack_basic.log
./testslamch | tee -a "${currentWorkingDir}"/lapack_basic.log
./testdlamch | tee -a "${currentWorkingDir}"/lapack_basic.log
./testsecond | tee -a "${currentWorkingDir}"/lapack_basic.log
./testdsecnd | tee -a "${currentWorkingDir}"/lapack_basic.log
./testieee | tee -a "${currentWorkingDir}"/lapack_basic.log
./testversion | tee -a "${currentWorkingDir}"/lapack_basic.log
popd || exit 1
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<"

echo "**************************"
echo "Running LAPACK Multithread Test"
echo "**************************"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>"
pushd blas_test/lapack_multi || exit 1
threadList=("1" "2" "3" "4" "5" "6" "7" "8")
for thread in "${threadList[@]}"
do
    echo "######## ${thread} Thread Test ########" | tee "${currentWorkingDir}"/lapack_multi_"${thread}".log
    OPENBLAS_NUM_THREADS=${thread} ${currentPython} lapack_testing.py -r -b test -d test | tee -a "${currentWorkingDir}"/lapack_multi_"${thread}".log
done
popd || exit 1
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<"