#!/bin/bash

scriptPath=$(dirname "$0")
pushd ${scriptPath}/.. || exit

hubName=${HUB_NAME:-docker.io}
hubAccount=${ACCOUNT:-flyinghorse0510}
dockerFile=${DOCKER_FILE:-Dockerfile.multiarch_starfive}
version=${VERSION:-0.2}
repoPrefix=${hubName}/${hubAccount}/multiarch-starfive

# get qemu source repo (starfive patched)
scripts/get_qemu_src.sh

# build image
docker build -f ${dockerFile} -t ${repoPrefix}-amd64:${version} .

# tag build image as latest
docker tag ${repoPrefix}-amd64:${version} ${repoPrefix}-amd64:latest

# push built images
docker push ${repoPrefix}-amd64:${version}
docker push ${repoPrefix}-amd64:latest

popd || exit