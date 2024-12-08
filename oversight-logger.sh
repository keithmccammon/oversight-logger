#!/bin/sh

# A logging script to be executed by the Objective-See OverSight tool:
#
#   https://objective-see.org/products/oversight.html
#
# Logs microphone and camera events, including the process path and user 
# if available. 
# 
# By Keith McCammon // kwm.me

HOME_DIR=/Users/username/
LOG_DIR="${HOME_DIR}/log"
LOG_PATH="${LOG_DIR}/oversight.log"

if [ ! -d "$LOG_DIR" ]; then
  mkdir -p "$LOG_DIR"
fi

PROCESS_PATH="NULL"
PROCESS_USER="NULL"

get_process_path() {
  PID=$1
  PROCESS_PATH=$(ps -p "$PID" -o command=)
  # If PROCESS_PATH is empty, reset it to NULL
  if [ -z "$PROCESS_PATH" ]; then
    PROCESS_PATH="NULL"
  fi
}

get_process_user() {
  PID=$1
  PROCESS_USER=$(ps -p "$PID" -o user=)
  # If PROCESS_USER is empty, reset it to NULL
  if [ -z "$PROCESS_USER" ]; then
    PROCESS_USER="NULL"
  fi
}

if [ "$5" = "-process" ]; then
  # Check if $6 (the PID) is provided
  if [ -z "$6" ]; then
    echo "Error: No PID provided." >> $LOG_PATH
    exit 1
  fi

  get_process_path "$6"
  get_process_user "$6"
fi

echo "$(date "+%Y-%m-%d %H:%M:%S") $PROCESS_PATH $PROCESS_USER $1 $2 $3 $4 $5 $6 $7 $8 $9" >> $LOG_PATH
