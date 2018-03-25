#!/bin/bash

function enviroment() {
  cd /server
  APP_ID="258550"
  mkdir -p /server/bin /server/install /server/logs /server/save
  PATH=$PATH:/server/bin:/server/install
  LD_LIBRARY_PATH=/steam/linux32:/steam/linux64
}

# Install is actuall install or update
function install() {
  /steam/steamcmd.sh +login anonymous +force_install_dir /server/install/ +app_update "$APP_ID" +quit
  ln -sf /docker/entrypoint.sh /server/bin/entrypoint
}

#  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/steam/linux32:/steam/linux64



function rust() {
  RUST_CMD="exec ./RustDedicated -batchmode -nographics \
    -server.ip "$IP" \
    -server.port "28015" \
    -rcon.ip "$IP" \
    -rcon.port "28016" \
    -rcon.password "$RCON_PASSWORD" \
    -server.maxplayers "$MAX_PLAYERS" \
    -server.hostname "$NAME" \
    -server.identity "$IDENTITY" \
    -server.level "$MAP" \
    -server.seed "$SEED" \
    -server.worldsize "$WORLDSIZE" \
    -server.saveinterval "$SAVE_INTERVAL" \
    -server.globalchat true \
    -server.description "$DESCRIPTION" \
    -server.headerimage "$HEADERIMAGE" \
    -server.url "$URL""
  echo "Starting Rust Server"
  tmux new-session -d -s server
  tmux send-keys 'cd /server/install' C-m
  tmux send-keys "$RUST_CMD"
  # tmux send-keys C-m
  tmux detach -s server
}


function start() {
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/steam/linux32:/steam/linux64  
  if [ ! -d /server/install/steamapps ]; then
    install
  fi
  # trap exit signals to stop function
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

function logs() {
  echo "Logs NOTHING WORKING ANYMORE"
}

# running is for when running the docker to keep the image and server going
function running() {
  while : ; do
    SERVER_PID=$(pgrep RustDedicated)
    if [ "$SERVER_PID" = "" ]; then
      echo "Server not running, restarting"
      rust
    else
      SERVER_TIME=$(ps -o etime= -p "$SERVER_PID")
      SERVER_CPU=$(ps -o %cpu= -p "$SERVER_PID")
      SERVER_MEM_KB=$(ps -o vsz= -p "$SERVER_PID")
      SERVER_MEM_MB=$(($SERVER_MEM_KB / 1024))
      echo "Server Running PID: $SERVER_PID, TIME: $SERVER_TIME, CPU: $SERVER_CPU, MEM: $SERVER_MEM_MB"
      sleep 15      
    fi
  done

}

function shell() {
  /bin/bash
  exit 0
}

enviroment

if [ "$1" != "" ]; then
  "$1"
else
  start
fi
