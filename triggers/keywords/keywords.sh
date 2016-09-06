[ -f functions.sh ] && source functions.sh

who="$1"
shift
chan="$1"
shift

# each word is stored in an associative array, with the actions to be taken as the array's contents.
# the variable $chan contains the channel that caused the trigger.
# the variable $who contains the nick that caused the trigger.
declare -A keywords
keywords[linux]="msg \"$chan\" \"awesome!\""
keywords[chicken]="msg \"$chan\" \"$who, I'm gonna grab me $(shuf -n1 -e "a case of beer" "a weed eater" "a 5 gallon jug of vaseline") and a $(shuf -n1 -e dead frozen live young) chicken, and have fun ALL NIGHT LONG!!!\""

wordList="$(echo "$@" | tr '[:space:]' $'\n' | sort -u)"
for w in ${wordList//[[:punct:]]/} ; do
if [[ -n "${keywords[${w,,}]}" ]]; then
eval ${keywords[${w,,}]}
fi
done
