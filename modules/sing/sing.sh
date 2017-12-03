[ -f functions.sh ] && source functions.sh

shift
chan="$1"
shift
#get the lyric text into a variable
lyricText="$(clyrics $@ | tr '[:space:]' ' ' | tr -s ' ' | fold -s -w 256)"
i=$(echo "$lyricText" | wc -l)
i=$(($RANDOM % $i + 1))
lyricText="$(echo "$lyricText" | tail +$i | head -1)"
#Display the lyric text
if [ ${#lyricText} -gt 15 ] ; then
msg "$chan" "${lyricText}"
exit 0
fi
msg "$chan" "no lyrics found for $@."
exit 0
