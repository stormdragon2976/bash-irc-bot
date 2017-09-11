[ -f functions.sh ] && source functions.sh

curl="$(command -v curl) --connect-timeout 5"
for l in $3 ; do
if [[ "${l#:}" =~ http://|https://|www\.*\.* ]]; then
pageTitle="$($curl -Ls "${l#:}" | sed -n 's/<title>\(.*\)<\/title>/\1/p' | head -1 | html2text | tr -s '[:space:]' ' ')"
shortLink="${l#*://}"
shortLink="${shortLink%%/*}"
if [ ${#pageTitle} -gt 1 ]; then
msg "$2" "$pageTitle at $shortLink"
fi
fi
done
