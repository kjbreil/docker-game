#!/bin/bash

function install() {
  echo "install"
}

function start() {
  echo "start"
}

if [ "$1" != "" ]; then
  if [ "$1" == "start" ]; then
    start
  fi
else
  install
fi