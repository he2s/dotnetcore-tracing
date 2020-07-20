#!/bin/bash

docker run -it --net=host -v /port:/port -v /container:/tmp --pid=container:${1} --cap-add ALL --name tracing --rm --privileged ${3}tracing:${2}
