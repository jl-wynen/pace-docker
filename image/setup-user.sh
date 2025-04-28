#!/usr/bin/env bash

current_user=$1
target_user=$2
target_uid=$3
target_gid=$4

# Rename the user and group to the desired name.
usermod -l "$target_user" "$current_user" -d/home/"$target_user" -m
groupmod -n "$target_user" "$current_user"

# Set UID and GID to give access to the project folder.
if [ "$(id -u)" != "$target_uid" ]; then
    usermod -u "$target_uid" "$target_user";
fi
if [ "$(id -g)" != "$target_gid" ]; then
    groupmod -g "$target_gid" "$target_user";
fi
