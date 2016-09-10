[ -f functions.sh ] && source functions.sh

userNick="$1"
shift
chan="$1"
shift
snack="${@:-$(shuf -n1 -e\
  "BBQ microchips"\
  "BBQ corn nuts"\
  "steak")}"
thanks="$(shuf -n1 -e "Thank you" "You're so awesome" "You shouldn't have" "You rock")"
favorite="$(shuf -n1 -e "my favorite" "yum yum" "this is bot heaven" "DELICIOUS")"

msg "$chan" "$thanks $userNick: $snack! $favorite!"
