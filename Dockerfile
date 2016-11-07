FROM ubuntu:xenial
MAINTAINER Shaun Murakami <stmuraka@us.ibm.com>

# Add Oracle Java repo
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu `cat /etc/lsb-release | grep CODENAME | cut -d '=' -f2` main" > /etc/apt/sources.list.d/oracle-java.list \
 && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu `cat /etc/lsb-release | grep CODENAME | cut -d '=' -f2` main" >> /etc/apt/sources.list.d/oracle-java.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv C2518248EEA14886

# Install components
RUN apt-get -y update \
 && echo "yes" | apt-get -y install \
        apt-utils \
        oracle-java8-installer \
        libxext6 \
        libxrender1 \
        libxtst6 \
        libxi6 \
        gtk2.0 \
# Cleanup package files
 && apt-get autoremove  \
 && apt-get autoclean

WORKDIR /root/
ARG MINECRAFT_JAR
ENV MINECRAFT_JAR ${MINECRAFT_JAR:-"http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar"}
ADD ${MINECRAFT_JAR} /root/

CMD java -jar $(basename ${MINECRAFT_JAR})
