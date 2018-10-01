#!/bin/bash
set -e

cd /home
for user in *; do
  chown -R $user:users $user/*
  chmod +w $user/*
done
