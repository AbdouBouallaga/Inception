#!/bin/bash

useradd "$NEWUSER"
echo "$NEWUSER:$NEWUSER_PASSWORD" | chpasswd
mkdir -p /home/"$NEWUSER"/
mkdir -p /var/run/vsftpd/empty/
echo "$NEWUSER" | tee -a /etc/vsftpd.userlist

exec "$@"