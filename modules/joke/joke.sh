[ -f functions.sh ] && source functions.sh

joke="$(curl -s --connect-timeout 5 'https://thatsagooden.tk/?api=txt&type=all&exclude=sex,little_johnny')"
joke="${joke//[[:space:]]/ }"
[ -n "$joke" ] && msg "$2" "$joke" || msg "$2" "No jokes found."
