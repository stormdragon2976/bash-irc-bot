[ -f functions.sh ] && source functions.sh

curl="$(command -v curl)"
for l in $3 ; do
if [[ "$l" =~ http://|https://|www\.*.* ]]; then
pageTitle="$($curl -Ls "${l/#:/}" | grep "<title>" | html2text | tr '[:space:]' ' ')"
shortLink="${l#*://}"
shortLink="${shortLink%%/*}"
if ! [[ "$pageTitle" =~ \ + ]]; then
msg "$2" "$pageTitle at $shortLink"
fi
fi
done
