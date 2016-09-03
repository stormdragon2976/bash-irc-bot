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

