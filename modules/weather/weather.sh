[ -f functions.sh ] && source functions.sh

if [ ${#3} -ge 5 ]; then
weatherInfo="$(curl -s "http://mobile.wunderground.com/cgi-bin/findweather/getForecast?brand=mobile&query=$3")"
weatherTemperature="$(echo "$weatherInfo" | grep -A 2 '<tr><td>Temperature</td>' | tr -cd '[:digit:]-.')"
weatherConditions="$(echo "$weatherInfo" | grep -A 1 '<tr><td>Conditions</td>' | tail -n1 | sed 's/<[^>]*>//g')"
weatherInfo="Currently your weather is $weatherConditions and $weatherTemperature degrees fahrenheit."
fi

if [ ${#weatherInfo} -lt 5 ]; then
weatherInfo="Sorry $1, no weather found for $3."
fi
msg "$2" "$1: $weatherInfo"
