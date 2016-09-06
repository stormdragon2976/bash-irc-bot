[ -f functions.sh ] && source functions.sh

chan="$1"
shift

# each word is stored in an associative array, with the actions to be taken as the array's contents.
declare -A keywords
keywords[linux]="msg '$chan' 'awesome!'"

wordList="$(echo "$@" | tr '[:space:]' $'\n' | sort -u)"
for w in ${wordList//[[:punct:]]/} ; do
if [[ -n "${keywords[${w,,}]}" ]]; then
eval ${keywords[${w,,}]}
fi
done
