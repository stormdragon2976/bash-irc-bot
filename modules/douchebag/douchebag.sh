[ -f functions.sh ] && source functions.sh

douchebag=(
"Don't ask to ask, just ask!"
'Use a pastebin website, bun only the one approved by the users of this channel, else someone may flood your screen with whining and bitching!')
msg "$2" "$1: $(shuf -n1 -e "${douchebag[@]}")"
