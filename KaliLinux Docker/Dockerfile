FROM kalilinux/kali-linux-docker

ENV LANG C.UTF-8

USER root
WORKDIR /root

RUN apt-get update && \
	apt-get upgrade -y
RUN echo 'Installing kali-linux package...' && \
	apt-get install -y kali-linux
RUN echo 'Installing kali-linux-wireless package...' && \
	apt-get install -y kali-linux-wireless
RUN echo 'Installing kali-linux-top10 package...' && \
	apt-get install -y kali-linux-top10
RUN alias l='ls -la' && \
	alias ll='ls -la'
RUN echo 'Installing zsh...' && \
	apt-get install -y zsh && \
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# docker build --rm=false -t pentest/kalilinux .
# docker run -it --rm -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/Workspaces:/root/Workspaces --name kali pentest/kalilinux