[ -f functions.sh ] && source functions.sh

shift
chan="$1"
shift
act "$chan" "$@"
