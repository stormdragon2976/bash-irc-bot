[ -f functions.sh ] && source functions.sh

shift
chan="$1"
shift
msg "$chan" "$@"
