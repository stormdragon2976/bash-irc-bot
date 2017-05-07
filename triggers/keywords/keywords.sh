[ -f functions.sh ] && source functions.sh

who="$1"
shift
chan="$1"
shift

# each word is stored in an associative array, with the actions to be taken as the array's contents.
# the variable $chan contains the channel that caused the trigger.
# the variable $who contains the nick that caused the trigger.
declare -A keywords
keywords[linux]="msg \"$chan\" \"Linux is $(shuf -n1 -e awesome God great lovely fantastic amazing wonderful)!\""
keywords[windows]="msg \"$chan\" \"$(shuf -n1 -e "Failure is not an option, it comes bundled with Windows!" "Apple got all pissed off because I farted in their store. It's not my falt they don't have Windows..." "Windows is dumb!" "Did you know that Micro Soft is Linda's pet name for Bill Gates?" "A computer without Windows is like a chocolate cake without the mustard." "Windows is stupid")!\""
keywords[emacs]="msg \"$chan\" \"$who, Real men use vim!\""
keywords[emacspeak]="msg \"$chan\" \"$who, Real men use vim!\""
keywords[nano]="msg \"$chan\" \"$who, Real men use vim!\""
keywords[gedit]="msg \"$chan\" \"$who, Real men use vim!\""
keywords[pluma]="msg \"$chan\" \"$who, Real men use vim!\""
keywords[sbl]="msg \"$chan\" \"Oh yeah! Let's all use SBL, a CLI reader that doesn't compile or work! That's a great  idea! Or, here's an idea... USE FENRIR DUMB ASS!\""
keywords[chicken]="msg \"$chan\" \"$who, I'm gonna grab me $(shuf -n1 -e "a case of beer" "a weed eater" "a 5 gallon jug of vaseline" "a can of wd40") and a $(shuf -n1 -e dead frozen live young) chicken, and $(shuf -n1 -e "have fun" "make chicks" "lay it like an egg" "put my beak where it don't belong") ALL NIGHT LONG!!!\""
keywords[dragonforce]="msg \"$chan\" \"$who: I love DragonForce!!!\""

wordList="$(echo "${@,,}" | tr '[:space:]' $'\n' | sort -u)"
for w in ${wordList//[[:punct:]]/} ; do
if [[ -n "${keywords[${w,,}]}" && "$lastWordMatch" != "${keywords[${w,,}]}" ]]; then
eval ${keywords[${w,,}]}
lastWordMatch="${keywords[${w,,}]}"
fi
done

# Example of dealing with multi word triggers.
# Reset wordList without sorting it and with spaces removed.
wordList="$(echo "${@,,}" | tr -d '[:space:]')"
if [[ "$wordList" =~ .*nowplaying:.*-.* ]]; then
act "$chan" "$(shuf -n1 -e "cranks the volume up to 11" "got soooo high at that show" "boogies down to the sound of the band")!"
fi
