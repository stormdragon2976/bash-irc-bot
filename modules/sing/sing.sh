[ -f functions.sh ] && source functions.sh

shift
chan="$1"
shift
#get the lyric text into a variable
trackName="${@//Ã/o}"
trackName="${trackName//:/-}"
trackName="$(echo "$trackName" | sed -r -e "s/((\w|\d| |\.|!|\?|')+ - (\w|\d| |\.|!|\?|')+)( +\[| +\(| +- ).*/\1/")"
# Random agent string
agent="$(shuf -n 1 -e \
    "Mozilla/5.0 (Android; Mobile; rv:40.0) Gecko/40.0 Firefox/40.0"\
    "Mozilla/5.0 (Android; Tablet; rv:40.0) Gecko/40.0 Firefox/40.0"\
    "Mozilla/5.0 (Linux; Android 4.4; Nexus 5 Build/_BuildID_) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/30.0.0.0 Mobile Safari/537.36")"
# Get our curl command
unset curl
if command -v torify &> /dev/null ; then
curl="torify "
fi
curl="${curl}curl"
#Lyricsmania
trackName="$(echo "$trackName" | sed -e "s/ /_/g" -e "s/([[:print:]]*)//g" -e "s/['\/\.]//g" -e 's/&/and/g')"
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
#remove simi-colons
lyricText="$(echo "$lyricText" | tr ';' ':' | sed 's/try { _402_Show(): } catch(e) {}//')"
#Display the lyric text
if [ ${#lyricText} -gt 15 ] ; then
msg "$chan" "${lyricText}"
exit 0
fi
msg "$chan" "no lyrics found for ${trackName}."
exit 0
