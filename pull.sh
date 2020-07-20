#!/bin/bash

docker login
docker pull dsfnctnl/tracing:${1}
docker logout
