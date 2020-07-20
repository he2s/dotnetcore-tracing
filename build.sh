#!/bin/bash

docker build . -t tracing:${1}
docker tag tracing:${1} dsfnctnl/tracing:${1}
