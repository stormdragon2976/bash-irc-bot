[ -f functions.sh ] && source functions.sh

douchebag=(
"Don't ask to ask, just ask!"
"STOP! READ THIS BEFORE YOU SPEAK! http://www.rockbox.org/wiki/IrcGuidelines"
"The human requesting this service can't be bothered to help you in person, so they requested a bot tell you that we don't discuss blah here, only blah+ which is totally different."
'Use a pastebin website, bun only the one approved by the users of this channel, else someone may flood your screen with whining and bitching!')
msg "$2" "$1: $(shuf -n1 -e "${douchebag[@]}")"
