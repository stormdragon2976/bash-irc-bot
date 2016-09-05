#!/bin/bash

if [ -z "$input" ]; then
input=".bot.cfg"
fi

msg()
{
  local msg="PRIVMSG $1"
shift
echo "$msg $@" | tee -a "$input"
}

reply()
{
shift
  local msg="PRIVMSG $1 :"
echo "$msg $@" | tee -a "$input"
}

act()
{
  local msg="PRIVMSG $1 :\x01ACTION"
shift
echo -e "$msg $@\x01" | tee -a "$input"
}

close_bot()
{
echo "QUIT :$quitMessage" >> "$input"
echo "exiting..."
sleep 10
}

trap close_bot EXIT $?
