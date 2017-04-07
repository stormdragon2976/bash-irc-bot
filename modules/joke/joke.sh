[ -f functions.sh ] && source functions.sh

joke="$(curl -s 'http://tambal.azurewebsites.net/joke/random')"
joke="${joke##*\":\"}"
joke="${joke:0:-2}"
msg "$2" "$joke"
