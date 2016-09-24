[ -f functions.sh ] && source functions.sh

quote="$(curl -s http://bash.org/?random)"
quote="$(echo "$quote" | grep -m 1 -A 10 '"Permanent link to this quote."')"
quote="${quote#*class=\"qt\">}"
quote="${quote//&lt;/<}"
quote="${quote//&gt;/>}"
quote="${quote%</p>*}"
quote="$(echo "$quote" | html2text)"
msg "$2" "$quote"
exit 0
