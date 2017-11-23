#!/usr/bin/env bash
docker build --rm=false -t pentest/kalilinux .
docker run -it --rm \
    --net="host" \
    --privileged \
    -e DISPLAY=$IP:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/Share/kali/:/root/share \
    --name kali pentest/kalilinux /bin/zsh
