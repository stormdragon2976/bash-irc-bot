[ -f functions.sh ] && source functions.sh

advice=(
'If love hurts, move slightly to the left.'
'Never sweat the petty stuff, but always pet the sweatty stuff.'
"There are three kinds of people in this world, those who can count, and those who can't"
"Never judge a man 'til you have walked a mile in his shoes. That way, if he turns out to be an ass hole you have his shoes and are a mile away.")
msg "$2" "$1: $(shuf -n1 -e "${advice[@]}")"
