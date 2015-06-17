FROM ubuntu:14.04

MAINTAINER Jostein Austvik Jacobsen

# Set working directory to home directory
WORKDIR /root/

# Use bash instead of sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install dependencies
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list
RUN sudo apt-get install -y software-properties-common
RUN sudo add-apt-repository -y ppa:cwchien/gradle
RUN apt-get update
RUN apt-get install -y openjdk-7-jre wget unzip gradle
RUN locale-gen en_US en_US.UTF-8

# Install Depify
RUN wget https://github.com/depify/depify-client/archive/1.0.1.zip -O depify.zip && unzip depify.zip
RUN cd depify-client* && gradle build && cd dist/depify* && chmod +x depify && ln --symbolic `pwd`/depify /bin/depify

#CMD ["depify"]
