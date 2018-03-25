#!/bin/bash

# Install is actuall install or update
function install() {
  cd /
  /steam/steamcmd.sh +login anonymous +force_install_dir /server/ +app_update 258550 +quit
}

#  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/steam/linux32:/steam/linux64

function rust() {
  echo "Starting Rust Server"  
  while : ; do
    cd /server
    exec ./RustDedicated -batchmode -nographics \
      -server.ip "$IP" \
      -server.port "28015" \
      -rcon.ip "$IP" \
      -rcon.port "28016" \
      -rcon.password "$RCON_PASSWORD" \
      -server.maxplayers "$MAX_PLAYERS" \
      -server.hostname "$SERVER_NAME" \
      -server.identity "$IDENTITY" \
      -server.level "$MAP" \
      -server.seed "$SEED" \
      -server.worldsize "$WORLDSIZE" \
      -server.saveinterval "$SAVE_INTERVAL" \
      -server.globalchat true \
      -server.description "$DESCRIPTION" \
      -server.headerimage "$HEADERIMAGE" \
      -server.url "$URL"
    echo "Rust Server Restarting"   
  done
}


function start() {
  if [ ! -d /server/steamapps ]; then
    install
  fi
     # trap exit signals
  trap stop INT SIGINT SIGTERM
  # sleep 10
  rust
}

# stop the rust server
function stop() {

  echo "Stopping!"
  
  # just to be sure wait 10 seconds
  sleep 10
  exit 0
}

# validate and update scripts and server
function update() {
  echo "Updating NOTHING"
}

# running is for when running the docker to keep the image and server going
function running() {
  # attach to the tmux session
  # tmux set -g status off && tmux attach 2> /dev/null

  # if something fails while attaching to the tmux session then just wait
  while : ; do
    # update
    sleep 3600
  done
}

function shell() {
  /bin/bash
  exit 0
}

if [ "$1" != "" ]; then
  "$1"
else
  start
fi
