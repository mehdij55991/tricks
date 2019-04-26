#!/bin/sh

# If we get an argument, use it for ssh port, otherwise use default of 22
if [ -n "$1" ]
then
    port=$1
else
    port=22
fi

host="wls-x86-hp07"
notify="$HOME/tools/irssi/notify-remote.sh"

set -e

socat -u tcp4-listen:12000,reuseaddr,fork,bind=127.0.0.1 exec:$notify &
pid=$!

# Attaches to 'irc' screen session
autossh $host -p $port -R 12000:localhost:12000 -t 'screen -raAD irc'

kill $pid
