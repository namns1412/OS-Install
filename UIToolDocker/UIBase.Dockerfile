FROM ubuntu:16.04

#####################################
ARG USER_NAME=developer
ARG USER_PASSWORD=123123123
#####################################
USER root
WORKDIR /root

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install dependencies
RUN \
    sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y --no-install-recommends ubuntu-desktop && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus && \
    apt-get install -y sudo software-properties-common git curl wget unzip net-tools

RUN \
    apt-get install -y libx11* && \
    apt-get install -y libxss1 && \
    apt-get install -y libnss3-dev && \
    apt-get install -y libxi6 libgconf-2-4 && \
    echo 'Installing OS dependencies' && \
    apt-get install -qq -y --fix-missing libxext-dev libxrender-dev libxslt1.1 \
        libxtst-dev libgtk2.0-0 libcanberra-gtk-module

# Install zsh
RUN apt-get install -y zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Clean up OS
RUN echo 'Cleaning up' && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y &&  \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Add developer user
RUN useradd -ms /bin/bash $USER_NAME&& \
    adduser $USER_NAME sudo && \
    echo "$USER_NAME:$USER_PASSWORD" | chpasswd

USER $USER_NAME

# docker build --rm=false -f UIBase.Dockerfile -t uitools/uibase .

