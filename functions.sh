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

act()
{
  local msg="PRIVMSG $1 :\x01ACTION"
shift
echo -e "$msg $@\x01" | tee -a "$input"
}

