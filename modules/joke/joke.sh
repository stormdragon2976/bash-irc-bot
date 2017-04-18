[ -f functions.sh ] && source functions.sh

joke="$(curl -s 'https://thatsagooden.tk/?api=txt&type=all&exclude=sex,little_johnny')"
joke="${joke//[[:space:]]/ }"
msg "$2" "$joke"
