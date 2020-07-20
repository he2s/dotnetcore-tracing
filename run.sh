#!/bin/bash

docker run -it --net=container:${1} -v /container:/tmp --pid=container:${1} --cap-add ALL --privileged tracing:${2}
