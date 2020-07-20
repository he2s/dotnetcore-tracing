#!/bin/bash

docker login
docker tag tracing:${1} dsfnctnl/tracing:${1}
docker push dsfnctnl/tracing:${1}
docker logout
