FROM raspbian/stretch:041518
MAINTAINER Eric Millet <emilletfr@gmail.com>
RUN apt-get update && apt-get install -y \
pkg-config \
curl \
libxml2 \
libssl \
zlib1g-dev \

RUN curl -s https://packagecloud.io/install/repositories/swift-arm/release/script.deb.sh | sudo bash
RUN apt-get install swift4=4.2

RUN mkdir /app
RUN cd /app && git clone https://github.com/emilletfr/domo-server-vapor-docker.git
WORKDIR /app/domo-server-vapor-docker

RUN swift build -c release
EXPOSE 8080
CMD .build/release/Run serve --hostname "0.0.0.0"
