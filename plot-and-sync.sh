#!/bin/bash
ssh-keyscan -t rsa $SYNC_HOST 2>&1 >> ~/.ssh/known_hosts
ssh -vvv $SYNC_HOST ls $SYNC_PATH || { echo "ssh test failed to $SYNC_HOST:$SYNC_PATH" ; exit 1; }
while true; do
  chia plots create -t /tmp -d /plots -r 4 -e -f $FARMER_KEY -p $POOL_KEY
  scp /plots/* $SYNC_HOST:$SYNC_PATH
  rm /plots/*
done
