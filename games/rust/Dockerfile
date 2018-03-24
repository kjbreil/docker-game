FROM kjbreil/steamcmd

LABEL maintainer="Kjell Breiland <kjell.breiland@gmail.com>"

COPY entrypoint.sh entrypoint.sh

RUN ./entrypoint.sh install

EXPOSE 28015/tcp 28015/udp 28016/tcp 28016/udp

VOLUME ["/server", "/save"]

ENTRYPOINT ["./entrypoint.sh"]

# CMD ["start"]
