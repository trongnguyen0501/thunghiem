#!/bin/bash

npm run build
for f in ./src/backend/*
do
    echo $f
    cp $f ./dist
done
clasp push -f