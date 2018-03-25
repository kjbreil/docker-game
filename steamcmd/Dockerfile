FROM kjbreil/gameserver-base

LABEL maintainer="Kjell Breiland <kjell.breiland@gmail.com>"

WORKDIR /server/steamcmd

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
  ./steamcmd.sh +quit

RUN ln -sf /server/steamcmd/steamcmd.sh /server/bin/steamcmd