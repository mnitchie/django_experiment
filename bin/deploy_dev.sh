#!/usr/bin/env bash

docker-compose -p django_experiment-api build

docker-compose \
    -p django_experiment-api \
    up \
    --remove-orphans
