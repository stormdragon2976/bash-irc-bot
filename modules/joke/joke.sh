[ -f functions.sh ] && source functions.sh

joke="$(curl -s 'https://thatsagooden.tk/?api=txt&type=all')"
joke="${joke//[[:space:]]/ }"
msg "$2" "$joke"
