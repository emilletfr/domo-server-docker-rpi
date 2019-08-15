FROM arm64v8/ubuntu:18.04
MAINTAINER Eric Millet <emilletfr@gmail.com>

ARG SWIFTPKG=https://packagecloud.io/swift-arm/release/packages/ubuntu/bionic/swift4_4.2.1_arm64.deb

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y \
  git           \
  libedit2      \
  libpython2.7 libcurl4 libxml2 libicu60 \
  libc6-dev     \
  libatomic1    \
  libpython3.5  \
  curl

RUN bash -c "curl -s https://packagecloud.io/install/repositories/swift-arm/release/script.deb.sh | bash"

RUN apt-get install -y swift4=4.2.1

RUN bash -c "echo '/usr/lib/swift/linux' > /etc/ld.so.conf.d/swift.conf;\
             echo '/usr/lib/swift/clang/lib/linux' >> /etc/ld.so.conf.d/swift.conf;\
             echo '/usr/lib/swift/pm' >> /etc/ld.so.conf.d/swift.conf;\
             ldconfig"

RUN useradd -u 501 --create-home --shell /bin/bash swift

USER swift
RUN cd /home/swift && git clone https://github.com/emilletfr/domo-server-vapor-docker.git
WORKDIR /home/swift/domo-server-vapor-docker


RUN swift build -c release
EXPOSE 8080
CMD .build/release/Run serve --hostname "0.0.0.0"
