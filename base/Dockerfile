FROM ubuntu:16.04

LABEL maintainer="Kjell Breiland <kjell.breiland@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
  binutils \
  mailutils \
  postfix \
  bc \
  curl \
  wget \
  file \
  bzip2 \
  gzip \
  unzip \
  xz-utils \
  libmariadb2 \
  bsdmainutils \
  python \
  util-linux \
  ca-certificates \
  tmux \
  lib32gcc1 \
  libstdc++6 \
  libstdc++6:i386 \
  libstdc++5:i386 \
  libsdl1.2debian \
  default-jdk \
  lib32tinfo5 \
  speex:i386 \
  libtbb2 \
  libcurl4-gnutls-dev:i386 \
  libtcmalloc-minimal4:i386 \
  libncurses5:i386 \
  zlib1g:i386 \
  libldap-2.4-2:i386 \
  libxrandr2:i386 \
  libglu1-mesa:i386 \
  libxtst6:i386 \
  libusb-1.0-0-dev:i386 \
  libxxf86vm1:i386 \
  libopenal1:i386 \
  libssl1.0.0:i386 \
  libgtk2.0-0:i386 \
  libdbus-glib-1-2:i386 \
  binutils \
  bc \
  lib32z1 \
  libnm-glib-dev:i386 \
  dos2unix \
  jq

RUN rm -rf /var/lib/apt/lists/* && \
  useradd -b / -m -s /bin/bash server



USER server
WORKDIR /server
RUN mkdir -p /server/bin /server/install /server/logs /server/save /server/steamcmd

