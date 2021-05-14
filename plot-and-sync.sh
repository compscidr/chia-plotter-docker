#!/bin/bash
ssh-keygen -R $SYNC_HOST
ssh-keyscan -t rsa $SYNC_HOST 2>&1 >> ~/.ssh/known_hosts
ssh -o StrictHostKeyChecking=no $SYNC_HOST ls $SYNC_PATH || { echo "ssh test failed to $SYNC_HOST:$SYNC_PATH" ; exit 1; }
. activate
while true; do
  chia plots create -t /tmp -d /plots -r 4 -e -f $FARMER_KEY -p $POOL_KEY
  scp -o StrictHostKeyChecking=no /plots/* $SYNC_HOST:$SYNC_PATH
  rm /plots/*
done
