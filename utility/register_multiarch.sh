#!/bin/bash

# parameter expansion
hubName=${HUB_NAME:-docker.io}
hubAccount=${ACCOUNT:-flyinghorse0510}
version=${VERSION:-latest}
repoPrefix=${hubName}/${hubAccount}/multiarch-starfive

sudo docker run --privileged --rm ${repoPrefix}-amd64:${version} --reset