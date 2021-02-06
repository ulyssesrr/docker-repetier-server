FROM balenalib/armv7hf-debian:buster

ARG ARCH="armhf"
ARG VERSION="1.0.3"

LABEL maintainer="ulyssesrr@gmail.com"
LABEL version="v${VERSION}"

ADD http://download.repetier.com/files/server/debian-${ARCH}/Repetier-Server-${VERSION}-Linux.deb repetier-server.deb

# Install with dpkg and remove the deb after
RUN dpkg --unpack repetier-server.deb \
    && rm -rf repetier-server.deb

# Create data directory at root and update configuration storage location with this path
RUN mkdir -p /data \
    && sed -i "s/var\/lib\/Repetier-Server/data/g" /usr/local/Repetier-Server/etc/RepetierServer.xml

EXPOSE 3344

CMD [ "/usr/local/Repetier-Server/bin/RepetierServer", "-c", "/usr/local/Repetier-Server/etc/RepetierServer.xml" ]
