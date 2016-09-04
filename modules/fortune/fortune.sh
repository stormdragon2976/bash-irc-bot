[ -f functions.sh ] && source functions.sh

fortune="$(command -v fortune)"
target="${3#fortune}"

if [ -z "$fortune" ]; then
msg "$2" "I do not have access to fortune."
else
fortuneText="$($fortune -a -e -s -n 512 $target || echo "No fortunes found.")"
fortuneText="$(echo "$fortuneText" | tr '[:space:]' ' ' | sed -e 's/"/\"/g')"
msg "$2" "$fortuneText"
fi
