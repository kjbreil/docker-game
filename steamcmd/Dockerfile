FROM kjbreil/gameserver-base


LABEL maintainer="Kjell Breiland <kjell.breiland@gmail.com>"
WORKDIR /server/steamcmd
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN ./steamcmd.sh +quit
WORKDIR /server
RUN ln -sf /server/steamcmd/steamcmd.sh /server/steamcmd/steamcmd