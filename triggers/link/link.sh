[ -f functions.sh ] && source functions.sh

for l in $3 ; do
if [[ "$l" =~ http://|https://|www\.* ]]; then
pageTitle="$(curl -s "$l" | grep "<title>" | sed 's#\(</\|</\)title>##g')"
shortLink="${l#*://}"
shortLink="${shortLink%%/*}"
msg "$2" "$pageTitle at $shortLink"
fi
done
