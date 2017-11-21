FROM kalilinux/kali-linux-docker

USER root
WORKDIR /root

RUN apt-get update && \
	apt-get upgrade -y
RUN apt-get install -y kali-linux
RUN apt-get install -y kali-linux-wireless
RUN apt-get install -y kali-linux-top10
RUN alias l='ls -la' && alias ll='ls -la'
RUN apt-get install -y zsh && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# docker build --rm=false -t pentest/kalilinux .
# docker run -it --rm -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/Workspaces:/root/Workspaces --name kali pentest/kalilinux