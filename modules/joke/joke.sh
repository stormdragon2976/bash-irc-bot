[ -f functions.sh ] && source functions.sh

agent="$(shuf -e -n1 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:7.0.1) Gecko/20100101 Firefox/7.0.1' 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100508 SeaMonkey/2.0.4' 'Mozilla/5.0 (Windows; U; MSIE 7.0; Windows NT 6.0; en-US)' 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; da-dk) AppleWebKit/533.21.1 (KHTML, like Gecko) Version/5.0.5 Safari')"
unset joke
curl="$(command -v torify) "
curl="${curl}$(command -v curl)"
curl="${curl//# /}"
while [ -z "$joke" ]; do
joke="$($curl -s -A "$agent" 'http://www.ajokeaday.com/jokes/random' | grep -A 9 '   data-description="' | grep -B 9 '   data-share-description="' | sed -e '  / data-share-description="/d' -e 's/^ *data-description="//' -e '/^"/d' -e 's/&quot;/"/g' -e "s/&#39;/'/g" | tr "[:space:]" " ")"
done
joke="${joke/\"\"/\"}"
msg "$2" "$joke"
exit 0
