FROM uitools/uibase

#########################################
ARG INTELLIJ_PACKGAGE=ideaIU-*.tar.gz
ARG VSCODE_PACKGAGE=code-*.tar.gz
ARG SOFTWARE_PATH=./Soft
#########################################
USER root
WORKDIR /opt

# Install Java.
RUN \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Clean up OS
RUN echo 'Cleaning up' && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y &&  \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

############################################
# Copy IntelliJ
COPY $SOFTWARE_PATH/$INTELLIJ_PACKGAGE .
RUN mkdir intellij && \
    tar zxvf $INTELLIJ_PACKGAGE -C intellij --strip-components 1
RUN rm -rf $INTELLIJ_PACKGAGE

RUN ln -s /opt/intellij/bin/idea.sh /usr/bin/idea

###########################################
# Copy vscode
COPY $SOFTWARE_PATH/$VSCODE_PACKGAGE .

RUN mkdir vscode && \
    tar zxvf $VSCODE_PACKGAGE -C vscode --strip-components 1
RUN rm -rf $VSCODE_PACKGAGE

RUN ln -s /opt/vscode/code /usr/bin/vscode
###########################################

# Switch developer user
WORKDIR /home/developer
USER developer

# docker build --rm=false -f DevTools.Dockerfile -t tools/devtools .
# docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/Workspaces/CodeLink:/home/developer/Workspaces --name=devtools -i tools/devtools

