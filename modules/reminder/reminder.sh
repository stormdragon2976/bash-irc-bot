[ -f functions.sh ] && source functions.sh

userNick="$1"
shift
chan="$1"
shift
time="$1"
shift

if ! [[ "$time" =~ ^[0-9]+[HhMmSs]$ ]]; then
  time="${time}s"
fi

if ! [[ "${time%[HhMmSs]}" =~ ^[0-9]+$ ]]; then
  reminderMessage="Times must be numeric (seconds)."
  msg "$chan" "$userNick: $reminderMessage"
else
  msg "$chan" "ok, $userNick, reminder in $time."
  reminderMessage="$@"
  if [[ "$reminderMessage" =~ ^[Tt]ell* ]]; then
    userNick="$(echo "${reminderMessage#[T|t]ell }" | cut -d ' ' -f1)"
reminderMessage="${reminderMessage#[Tt]ell }"
reminderMessage="${reminderMessage#* }"
  fi
  sleep $time && msg "$chan" "$userNick: $reminderMessage"&
fi
