[ -f functions.sh ] && source functions.sh

userNick="$1"
shift
chan="$1"
shift
#get the lyric text into a variable
trackName="${@//:/ - }"
trackName="${@//Ö/o}"
# Try to work around some common tags that will fail to find lyrics.
trackName="${trackName//\//_}"
curl="$(command -v curl)"
trackName="$(echo "$trackName" | sed -e "s/ /_/g" -e 's/([[:print:]]*)//g' -e "s/['\/\.]//g" -e 's/&/and/g' -e 's/ö/o/g')"
artist="$(echo "${trackName,,}" | cut -d "-" -f 1 | sed -e 's/_$//' -e 's/^the_\(.*\)/\1_the/')"
song="$(echo "${trackName,,}" | cut -d "-" -f 2 | sed 's/^_//')"
lyricsUrl="http://www.lyricsmania.com/${song}_lyrics_${artist}.html"
lyricText="$($curl -s "$lyricsUrl" | grep -A 100 '<strong>Lyrics to ' | grep -B 100 '</div> <!-- lyrics-body -->' | tail -n +2 | head -n -2 | sed -e 's/<[^>]*>//g' -e 's/<br \/>/\n/g' -e 's/<\/div>.*//')"
#get the number of lines in the text 
lyricMaxLines=$(echo "$lyricText" | wc -l)
#keep track of 10 line chunks of text for your starting point.
x=10
lyricStartLine=$x
while [[ $x -le $(($lyricMaxLines - 10)) ]] ; do
x=$((x + 10))
lyricStartLine="$lyricStartLine $x"
done
#pass the starting options through shuf so we can get our starting line
lyricStartLine=$(shuf -n 1 -e $lyricStartLine)
#we only need to do the head, tail manipulation if there's more than one line.
if [ $lyricMaxLines -gt 10 ] ; then
    lyricText="$(echo "$lyricText" | tail -n $lyricStartLine | head -n 10)"
fi
#Make sure all white space is not an enter or vertical space of any kind.
lyricText="$(echo "$lyricText" | tr "[:space:]" " " | tr -s "[:space:]")"
#sometimes lyrics are just one long line with everything. If this happens, cut it down so it's not too long for the 512 character channel limit.
if [ ${#lyricText} -gt 412 ] ; then
    lyricText="${lyricText:0:409}... "
    lyricText="$(echo "$lyricText" | rev | cut -d " " -f 1- | rev)"
fi
    lyricText="$(echo "$lyricText" | sed -e 's/try {.*//g' -e 's/  +_402_Show//g')"
#Display the lyric text
if [ ${#lyricText} -gt 15 ] ; then
act "$chan" "sings, '${lyricText}'"
else
msg "$chan" "Sorry $userNick: I couldn't find any lyrics for $@"
fi
