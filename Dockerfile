FROM alpine AS builder
ARG UNRAR_VER=7.0.9
ADD https://www.rarlab.com/rar/unrarsrc-${UNRAR_VER}.tar.gz /tmp/unrar.tar.gz
RUN apk --update --no-cache add build-base && \
    tar -xzf /tmp/unrar.tar.gz && \
    cd unrar && \
    sed -i 's|LDFLAGS=-pthread|LDFLAGS=-pthread -static|' makefile && \
    sed -i 's|CXXFLAGS=-march=native |CXXFLAGS=|' makefile && \
    make -f makefile && \
    install -Dm 755 unrar /usr/bin/unrar

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.19

LABEL maintainer="salty"

ARG RUTORRENT_VERSION=v5.0.0
ARG DUMPTORRENT_VERSION=v1.3
ARG DUMPTORRENT_FILE="dumptorrent_linux_amd64"

RUN \
	echo "**** install packages ****" && \
	apk add --no-cache --upgrade \
		apache2-utils \
		bash \
		bind-tools \
		binutils \
		brotli \
		ca-certificates \
		coreutils \
  		cppunit-dev \
		dhclient \
		ffmpeg \
  		findutils \
		geoip \
		grep \
		gzip \
		libstdc++ \
		mediainfo \
		ncurses \
		nginx \
		nginx-mod-http-dav-ext \
		nginx-mod-http-geoip2 \
		openssl \
		php83 \
		php83-bcmath \
		php83-ctype \
		php83-curl \
		php83-dom \
		php83-fileinfo \
		php83-fpm \
		php83-mbstring \
		php83-openssl \
		php83-phar \
		php83-posix \
		php83-session \
		php83-sockets \
		php83-xml \
		php83-zip \
		python3 \
		py3-pip \
		rtorrent \
		screen \
		shadow \
		sox \
		tar \
		tzdata \
  		udns \
		unzip \
		util-linux \
		zip

RUN \
	echo "**** setup python pip dependencies ****" && \
 	pip3 install --upgrade --break-system-packages pip && \
	pip3 install --no-cache-dir --upgrade --break-system-packages \
		cloudscraper \
		cfscrape

COPY --from=builder /usr/bin/unrar /usr/bin/unrar

RUN \
	echo "**** install rutorrent ****" && \
	curl -o \
		/tmp/rutorrent.zip -L \
		"https://github.com/Novik/ruTorrent/archive/refs/tags/${RUTORRENT_VERSION}.zip" && \
	mkdir -p \
		/app/rutorrent \
		/tmp/rutorrent \
		/defaults/rutorrent-conf && \
	unzip -d /tmp/rutorrent/ /tmp/rutorrent.zip && \
	mv /tmp/rutorrent/ruTorrent*/* /app/rutorrent/ && \
	mv /app/rutorrent/conf/* \
		/defaults/rutorrent-conf/ && \
	rm -rf \
		/defaults/rutorrent-conf/users && \
	echo "**** cleanup ****" && \
	rm -rf \
		/root/.cache

RUN set -ex \
    && echo "Downloading version: ${DUMPTORRENT_VERSION}" \
    && echo "File name: ${DUMPTORRENT_FILE}" \
    && curl -fsSL -o /tmp/${DUMPTORRENT_FILE}.tar.gz \
       "https://github.com/TheGoblinHero/dumptorrent/releases/download/${DUMPTORRENT_VERSION}/${DUMPTORRENT_FILE}.tar.gz" \
    && tar -xzvf /tmp/${DUMPTORRENT_FILE}.tar.gz -C /tmp \
    && ls -l /tmp \
    && for binary in dumptorrent scrapec; do \
         if [ -f /tmp/$binary ]; then \
           mv /tmp/$binary /usr/local/bin/; \
           chmod +x /usr/local/bin/$binary; \
           echo "Installed $binary to /usr/local/bin/"; \
         else \
           echo "Expected file $binary not found in the archive"; \
           exit 1; \
         fi; \
       done \
    && rm -rf /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
