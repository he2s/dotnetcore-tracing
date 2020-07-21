#!/bin/bash

docker login
docker tag dotnetcore-tracing:${1} dsfnctnl/dotnetcore-tracing:${1}
docker push dsfnctnl/dotnetcore-tracing:${1}
docker logout
