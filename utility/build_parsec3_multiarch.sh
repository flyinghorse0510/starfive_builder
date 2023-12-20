#!/bin/bash

scriptPath=$(dirname "$0")
pushd ${scriptPath}/.. || exit

# parameter expansion
hubName=${HUB_NAME:-docker.io}
hubAccount=${ACCOUNT:-flyinghorse0510}
version=${VERSION:-latest}
repoPrefix=${hubName}/${hubAccount}/parsec3-builder

# get parsec3 source
./scripts/get_parsec3_src.sh

# build multiarch parsec3
archList=("amd64" "arm64" "riscv64")

for arch in "${archList[@]}"
do
    docker run --platform=linux/${arch} --rm -it -v ./src/parsec3:/parsec3 -v ./parsec3_multiarch/${arch}:/output ${repoPrefix}:${version} all
done

echo "Archiving parsec3 multiarch images..."
tar -czf parsec3_images_multiarch_${version}.tar.gz parsec3_multiarch

popd || exit