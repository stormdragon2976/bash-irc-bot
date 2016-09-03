[ -f functions.sh ] && source functions.sh

unset fortune
unset target
fortune="$(command -v fortune)"
if [ $# -ge 2 ]; then
target="$3"
fi

if [ -z "$fortune" ]; then
msg "$2" "I do not have access to fortune."
else
msg "$2" "$($fortune -aesn 512  $target | tr '[:space:]' ' ' | sed -e 's/"/\"/g')"
fi
