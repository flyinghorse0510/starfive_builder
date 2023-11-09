#!/bin/bash
evilWord="-Bdynamic"

gccArgs="$@"

evilGccArgs=${gccArgs//${evilWord}/-Bstatic}

gcc-11 ${evilGccArgs}