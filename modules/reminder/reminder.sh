[ -f functions.sh ] && source functions.sh

userNick="$1"
shift
chan="$1"
shift
time="$1"
shift

if ! [[ "$time" =~ ^[0-9]+$ ]]; then
  reminderMessage="Times must be numeric (seconds)."
msg "$chan" "$userNick: $reminderMessage"
else
msg "$chan" "ok, $userNick, reminder in $time seconds."
reminderMessage="$@"
  sleep $time && msg "$chan" "$userNick $reminderMessage"&
fi
