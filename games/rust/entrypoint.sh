#!/bin/bash

function enviroment() {
  export -f enviroment
  export APP_ID="258550"
  export EXECUTABLE="RustDedicated"
  export CMD_LINE="-server.ip "$IP" \
    -server.port "28015" \
    -rcon.ip "$IP" \
    -rcon.port "28016" \
    -rcon.password "$RCON_PASSWORD" \
    -server.maxplayers "$MAX_PLAYERS" \
    -server.hostname \"""$NAME""\" \
    -server.identity "$IDENTITY" \
    -server.level \"""$MAP""\" \
    -server.seed "$SEED" \
    -server.worldsize "$WORLDSIZE" \
    -server.saveinterval "$SAVE_INTERVAL" \
    -server.globalchat true \
    -server.description \"""$DESCRIPTION""\" \
    -server.headerimage \"""$HEADERIMAGE""\" \
    -server.url \"""$URL""\" "
  mkdir -p /server/bin /server/install /server/logs /server/save
  STEAM_LIBS=/server/steamcmd/linux32:/server/steamcmd/linux64
  export PATH=$PATH:/server/bin:/server/steamcmd:/server/install
  export LD_LIBRARY_PATH=$STEAM_LIBS  
}

function install_server() {
  enviroment
  steamcmd +login anonymous +force_install_dir /server/install/ +app_update "$APP_ID" +quit
}

# Install is actually install or update if needed but wont validate
function install() {
  export -f install_server
  # export -f install_server
  su server -c "bash -c install_server"
}

function update_server() {
  enviroment
  steamcmd +login anonymous +force_install_dir /server/install/ +app_update "$APP_ID" -validate +quit
}

# validate server and force update
function update() {
  export -f update_server
  su server -c "bash -c update_server"
}

function info_server() {
  enviroment
  steamcmd +login anonymous +app_info_print "$APP_ID" +quit
  # steamcmd +login anonymous +app_info_update 1 +app_info_print "$APP_ID" +quit
}

function info() {
  export -f info_server
  su server -c "bash -c info_server"
}


function server() {
  export -f start_server
  su server -c "bash -c start_server"
}

function start_server() {
  export PATH="$PATH":/server/bin:/server/steamcmd:/server/install
  export LD_LIBRARY_PATH=/server/bin:/server/steamcmd:/server/install
  
  FORCE_CMD_LINE=" -batchmode -nographics "$CMD_LINE""
  SERVER_CMD="exec ./"$EXECUTABLE" "$FORCE_CMD_LINE""
  
  echo "Starting Rust Server"
  tmux new-session -d -s server
  tmux send-keys 'cd /server/install' C-m
  tmux send-keys "$SERVER_CMD"
  tmux send-keys C-m
  tmux detach -s server
}



function server_cmd() {
  FORCE_CMD_LINE=" -batchmode -nographics "$CMD_LINE""
  SERVER_CMD="exec ./"$EXECUTABLE" "$FORCE_CMD_LINE""
  echo $SERVER_CMD
}

function tmux() {
  su server -c "tmux a -t server"
}


function start() {
  if [ ! -d /server/install/steamapps ]; then
    install
  fi
  # trap exit signals to stop function
  trap stop INT SIGINT SIGTERM
  server
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


function logs() {
  echo "Logs NOTHING WORKING ANYMORE"
}

# running is for when running the docker to keep the image and server going
function running() {
  while : ; do
    SERVER_PID=$(pgrep $EXECUTABLE)
    if [ "$SERVER_PID" = "" ]; then
      echo "Server not running, restarting"
      server
    else
      SERVER_TIME=$(ps -o etime= -p "$SERVER_PID")
      SERVER_CPU=$(ps -o %cpu= -p "$SERVER_PID")
      SERVER_MEM_KB=$(ps -o vsz= -p "$SERVER_PID")
      SERVER_MEM_MB=$(($SERVER_MEM_KB / 1024))
      echo "Server Running PID: $SERVER_PID, TIME: $SERVER_TIME, CPU: $SERVER_CPU, MEM: $SERVER_MEM_MB"
      sleep 10      
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
