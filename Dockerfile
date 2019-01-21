FROM raspbian/stretch:041518
MAINTAINER Eric Millet <emilletfr@gmail.com>
RUN apt-get update
RUN apt-get install -y pkg-config
RUN apt-get install -y curl
RUN apt-get install -y libxml2
RUN apt-get install -y libssl-dev
RUN apt-get install -y zlib1g-dev

RUN curl -s https://packagecloud.io/install/repositories/swift-arm/release/script.deb.sh | sudo bash
RUN apt-get install -y swift4=4.2

RUN apt-get install -y git

RUN mkdir /app
RUN cd /app && git clone https://github.com/emilletfr/domo-server-vapor-docker.git
WORKDIR /app/domo-server-vapor-docker

RUN swift build -c release
EXPOSE 8080
CMD .build/release/Run serve --hostname "0.0.0.0"
