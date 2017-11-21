#!/usr/bin/env bash
docker build --rm=false -t pentest/kalilinux .
docker run -it --rm \
    -e DISPLAY=$IP:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/Workspaces:/root/Workspaces \
    --name kali pentest/kalilinux