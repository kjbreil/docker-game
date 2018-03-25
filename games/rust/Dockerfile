FROM kjbreil/steamcmd

LABEL maintainer="Kjell Breiland <kjell.breiland@gmail.com>"

ENV IP "0.0.0.0"
ENV IDENTITY "docker"
ENV RCON_PASSWORD "docker"
ENV MAX_PLAYERS "69"
ENV NAME "\"Rust Docker\""
ENV IDENTITY "my_server_identity"
ENV MAP "Procedural Map"
ENV SEED "12345"
ENV WORLDSIZE "3000"
ENV SAVE_INTERVAL "300"
ENV DESCRIPTION "Default Description"
ENV HEADERIMAGE ""
ENV URL "https://github.com/kjbreil/docker-game"

COPY entrypoint.sh /docker/entrypoint.sh 
RUN dos2unix /docker/entrypoint.sh

EXPOSE 28015/tcp 28015/udp 28016/tcp 28016/udp

USER server

WORKDIR /server

RUN /docker/entrypoint.sh install

ENTRYPOINT ["/docker/entrypoint.sh"]

CMD ["start"]