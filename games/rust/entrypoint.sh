#!/bin/bash

# Install is actuall install or update
function install() {
  /steam/steamcmd.sh +login anonymous +force_install_dir /server/ +app_update 258550 +quit
}

func rust() {
  exec ./RustDedicated -batchmode -nographics \
    -server.ip IPAddressHere \
    -server.port 28015 \
    -rcon.ip IPAddressHere \
    -rcon.port 28016 \
    -rcon.password "rcon password here" \
    -server.maxplayers 75 \
    -server.hostname "Server Name" \
    -server.identity "my_server_identity" \
    -server.level "Procedural Map" \
    -server.seed 12345 \
    -server.worldsize 3000 \
    -server.saveinterval 300 \-server.globalchat true \
    -server.description "Description Here" \
    -server.headerimage "512x256px JPG/PNG headerimage link here" \
    -server.url "Website Here"

}


function start() {
  if [ ! -d /server ]; then
    install
  fi
     # trap exit signals
    trap stop INT SIGINT SIGTERM
    # sleep 10
    echo "RUNNING?"
    running
  
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
}


function test2() {
  echo "TEST - 2"
}


if [ "$1" != "" ]; then
  if [ "$1" == "install" ]; then
    install
  fi
  if [ "$1" == "shell" ]; then
    shell
  fi
else
  start
fi
