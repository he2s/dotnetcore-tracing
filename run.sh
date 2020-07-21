#!/bin/bash

docker run -it -v /tracing-port:/tracing-port -v /container:/tmp --net=host --pid=container:${1} --cap-add ALL --privileged --name dotnetcore-tracing ${3}dotnetcore-tracing:${2}
