#!/bin/bash

scriptPath=$(dirname "$0")
pushd ${scriptPath}/.. || exit

# parameter expansion
hubName=${HUB_NAME:-docker.io}
hubAccount=${ACCOUNT:-flyinghorse0510}
version=${VERSION:-0.3}
dockerFile=${DOCKER_FILE:-Dockerfile.parsec3_builder}
repoPrefix=${hubName}/${hubAccount}/parsec3-builder

# build images
docker build --platform=linux/amd64 -f ${dockerFile} -t ${repoPrefix}-amd64:${version} .
docker build --platform=linux/arm64 -f ${dockerFile} -t ${repoPrefix}-arm64:${version} .
docker build --platform=linux/riscv64 -f ${dockerFile} -t ${repoPrefix}-riscv64:${version} .

# tag built images as latest
docker tag ${repoPrefix}-amd64:${version} ${repoPrefix}-amd64:latest
docker tag ${repoPrefix}-arm64:${version} ${repoPrefix}-arm64:latest
docker tag ${repoPrefix}-riscv64:${version} ${repoPrefix}-riscv64:latest

# push built images
docker push ${repoPrefix}-amd64:${version}
docker push ${repoPrefix}-arm64:${version}
docker push ${repoPrefix}-riscv64:${version}
docker push ${repoPrefix}-amd64:latest
docker push ${repoPrefix}-arm64:latest
docker push ${repoPrefix}-riscv64:latest

# delete existing manifest
docker manifest rm ${repoPrefix}:${version}
docker manifest rm ${repoPrefix}:latest

# create manifest for upload
docker manifest create ${repoPrefix}:${version} ${repoPrefix}-amd64:${version} ${repoPrefix}-arm64:${version} ${repoPrefix}-riscv64:${version}
docker manifest create ${repoPrefix}:latest ${repoPrefix}-amd64:latest ${repoPrefix}-arm64:latest ${repoPrefix}-riscv64:latest

# push manifest
docker manifest push ${repoPrefix}:${version}
docker manifest push ${repoPrefix}:latest

popd || exit