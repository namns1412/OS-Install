FROM ubuntu:16.04

USER root
WORKDIR /opt

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install dependencies
RUN \
	sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update -qq && \
    echo 'Installing OS dependencies' && \
    apt-get install -qq -y --fix-missing sudo software-properties-common git libxext-dev libxrender-dev libxslt1.1 \
        libxtst-dev libgtk2.0-0 libcanberra-gtk-module unzip wget && \
    echo 'Cleaning up' && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y &&  \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Install Java.
RUN \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	apt-get install -y oracle-java8-installer && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Copy Intellij
COPY ideaIU-*.tar.gz .
RUN mkdir intellij && \
	tar zxvf ideaIU-*.tar.gz -C intellij --strip-components 1
RUN rm -rf ideaIU-*.tar.gz
RUN ls -la intellij

# Run Intellij
RUN useradd -ms /bin/bash developer
USER developer
CMD ["/opt/intellij/bin/idea.sh"]

# docker build --rm=false -t tools/intellij .
# docker run -it --rm -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/Workspaces/CodeLink:/home/developer/Workspaces --name intellij tools/intellij