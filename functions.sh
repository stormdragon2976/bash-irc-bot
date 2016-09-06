#!/bin/bash

if [ -z "$input" ]; then
input=".botinput"
fi

msg()
{
  local msg="PRIVMSG $1 :"
shift
echo -en "${msg}$@\r\n" | tee -a "$input"
}

reply()
{
shift
  local msg="PRIVMSG $1 :"
echo -en "${msg}$@\r\n" | tee -a "$input"
}

act()
{
  local msg="PRIVMSG $1 :\x01ACTION"
shift
echo -en "$msg $@\x01\r\n" | tee -a "$input"
}
