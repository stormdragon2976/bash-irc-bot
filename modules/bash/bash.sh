[ -f functions.sh ] && source functions.sh

quote="$(curl -s http://bash.org/?random)"
quote="$(echo "$quote" | grep -m 1 -A 10 '"Permanent link to this quote."')"
quote="${quote#*class=\"qt\">}"
quote="${quote//&lt;/<}"
quote="${quote//&gt;/>}"
quote="${quote%%<p class*}"
quote="$(echo "$quote" | html2text)"
msg "$2" "$(echo "$quote" | tr -s '[:space:]' ' ')"
exit 0
