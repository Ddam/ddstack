#!/bin/sh
set -e

for webserver in $(IFS=',';echo ${ANSISTRANO_WEBSERVERS}); do
    pass=$(echo $webserver | awk -F: '{print $1}')
    server=$(echo $webserver | awk -F: '{print $2}')

    sshpass -p $pass ssh-copy-id -o StrictHostKeyChecking=no $server
done

exec "$@"
