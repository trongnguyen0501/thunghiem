#!/bin/bash

for f in ./src/backend/*
do
    echo $f
    cp $f ./dist
done

clasp push -f

deployments=$(clasp deployments)
deployment_string=$(echo "$deployments" | sed '3!d')
id_start=$(echo "$deployment_string" | awk '{print index($0, "-") + 1}')
deployment_id=$(echo "$deployment_string" | cut -d' ' -f "$id_start")
deployment_id="${deployment_id##-}"

if [ -z "$deployment_id" ]; then
    clasp deploy -d "$@"
else
    clasp deploy -i "$deployment_id" -d "$@"
fi