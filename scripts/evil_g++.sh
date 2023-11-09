#!/bin/bash
evilWord="-Bdynamic"

gppArgs="$@"

evilGppArgs=${gppArgs//${evilWord}/-Bstatic}

g++-11 ${evilGppArgs}