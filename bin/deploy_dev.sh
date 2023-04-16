#!/usr/bin/env bash

docker-compose -p django_experiment build

docker-compose \
    -p django_experiment \
    up \
    --remove-orphans
