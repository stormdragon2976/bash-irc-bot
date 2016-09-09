[ -f functions.sh ] && source functions.sh

pong="${3:-ping}"
pong="${pong//i/o}"
pong="${pong//I/O}"
msg "$2" "$1: $pong"
