[ -f functions.sh ] && source functions.sh

joke="$(curl -s api.yomomma.info | sed -e 's/{"joke":"//' -e 's/"}$//')"
joke="${joke//[[:space:]]/ }"
msg "$2" "$joke"
