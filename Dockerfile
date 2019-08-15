FROM futurejones/swiftlang
MAINTAINER Eric Millet <emilletfr@gmail.com>


RUN cd /home/swift && git clone https://github.com/emilletfr/domo-server-vapor-docker.git
WORKDIR /home/swift/domo-server-vapor-docker


RUN swift build -c release
EXPOSE 8080
CMD .build/release/Run serve --hostname "0.0.0.0"
