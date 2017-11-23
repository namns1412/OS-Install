#!/usr/bin/env bash
docker build --rm=false -t tools/intellij .
docker run -it --rm \
    -e DISPLAY=$IP:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/Workspaces/CodeLink:/home/developer/Workspaces \
    --name intellij tools/intellij