When creating modules, remember to source the functions file so all the info it contains will be available.
[ -f functions.sh ] && source functions.sh
Modules are given two parameters, $1 is the nick of the person who called the module, and $2 is the channel. You need at least $2 when sending a message to a channel, like the following:
msg "$2" the rest of your message (quotes are optional, but be careful to escape things if you don't use quotes.)
