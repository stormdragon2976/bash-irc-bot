[ -f functions.sh ] && source functions.sh

units="$(command -v units)"

shift
chan="$1"
shift
if [ -z "$units" ]; then
msg "$chan" "I do not have access to units."
else
msg "$chan" "$($units -v $@ | head -n1)"
fi
