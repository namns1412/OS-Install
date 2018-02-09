FROM ubuntu:16.04

#####################################
ARG USER_NAME=iron
ARG USER_PASSWORD=man
ENV PROCESS_USER=$USER_NAME
#####################################
USER root
WORKDIR /root

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install dependencies
RUN \
    echo 'Installing OS dependencies' && \
    sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y --no-install-recommends ubuntu-desktop && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus && \
    apt-get install -y sudo software-properties-common git curl wget unzip net-tools vim

RUN \
    apt-get install -y libx11* libxss1 libnss3-dev libxi6 libgconf-2-4 && \
    apt-get install -y --fix-missing libxext-dev libxrender-dev libxslt1.1 \
        libxtst-dev libgtk2.0-0 libcanberra-gtk-module

# Clean up OS
RUN echo 'Cleaning up' && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y &&  \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Add developer user
RUN echo 'Adding user' && \
    useradd -ms /bin/bash $USER_NAME && \
    adduser $USER_NAME sudo && \
    echo "$USER_NAME:$USER_PASSWORD" | chpasswd

WORKDIR /home/$USER_NAME
USER $USER_NAME

# docker build --rm=false -f UIBase.Dockerfile -t uitools/uibase .

