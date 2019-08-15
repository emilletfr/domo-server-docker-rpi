FROM ubuntu:18.04
MAINTAINER Eric Millet <emilletfr@gmail.com>

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get -q install -y \
    libatomic1 \
    libbsd0 \
    libcurl4 \
    libxml2 \
    libedit2 \
    libsqlite3-0 \
    libc6-dev \
    binutils \
    libgcc-5-dev \
    libstdc++-5-dev \
    libpython2.7 \
    tzdata \
    git \
    curl \
    pkg-config
    
RUN curl -s https://packagecloud.io/install/repositories/swift-arm/docker/script.deb.sh | bash

RUN sudo apt-get install swiftlang-dev=1.0-5.0.1

# delete all the apt list files since they're big and get stale quickly
RUN rm -rf /var/lib/apt/lists/*

#RUN apt-get install -y swift4=4.2

#RUN apt-get install -y git

RUN mkdir /app
RUN cd /app && git clone https://github.com/emilletfr/domo-server-vapor-docker.git
WORKDIR /app/domo-server-vapor-docker

RUN swift build -c release
EXPOSE 8080
CMD .build/release/Run serve --hostname "0.0.0.0"
