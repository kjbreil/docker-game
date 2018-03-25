#!/bin/bash

# Install is actuall install or update
function install() {
  cd /
  /steam/steamcmd.sh +login anonymous +force_install_dir /server/ +app_update 258550 +quit
}

#  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/steam/linux32:/steam/linux64

function rust() {
  echo "Starting Rust Server"
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/steam/linux32:/steam/linux64  
  # while : ; do
  tmux new-session -d -s server
  tmux send-keys 'cd /server' C-m
  tmux send-keys 'exec ./RustDedicated -batchmode -nographics \
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
    -server.url "$URL"' C-m
  tmux detach -s server
  # echo "Rust Server Restarting"   
  # done
}


function start() {
  if [ ! -d /server/steamapps ]; then
    install
  fi
  trap stop INT SIGINT SIGTERM
  rust
  running
}

# stop the rust server
function stop() {

  echo "Stopping!"

  SERVER_PID=$(pgrep RustDedicated)
  if [ "$SERVER_PID" != "" ]; then
    echo "Stopping rust server"
    kill "$SERVER_PID"
  fi
  # just to be sure wait 10 seconds
  # sleep 10
  exit 0
}

# validate and update scripts and server
function update() {
  echo "Updating NOTHING"
}

# running is for when running the docker to keep the image and server going
function running() {
  while : ; do
    sleep 5
    SERVER_PID=$(pgrep RustDedicated)
    SERVER_TIME=$(ps -o etime= -p "$SERVER_PID")
    if [ "$SERVER_PID" = "" ]; then
      echo "Server not running, restarting"
      rust
    else
      echo "Server Running PID: $SERVER_PID, TIME: $SERVER_TIME"
    fi
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
