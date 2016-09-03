#!/bin/bash

msg()
{
  local msg="PRIVMSG $1"
shift
echo "$msg $@" | tee -a "$log"
}

