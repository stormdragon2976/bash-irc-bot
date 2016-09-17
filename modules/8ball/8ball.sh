[ -f functions.sh ] && source functions.sh

userNick="$1"
shift
chan="$1"
shift
question="$@"

if [ "${question: -1:1}" != "?" ]; then
  message="Please phrase your answer in the form of a question."
else
case "${question,,}" in
"do you have"*"balls?")
if [[ "$(echo "$question" | tr -cd '[:digit:]')" =~ ^[0-9]+$ ]]; then
message="I just have the 2 big ol' hairy balls $(shuf -n 1 -e "on your chin" "in your mouth")."
else
message="I have 2 greate big ol' hairy balls. You wanna touch 'em?"
fi
;;
"does god exist?"|"is god real?"|"is there a god?")
message="According to your $(shuf -e -n1 "mother" "daughter" "sister" "wife" "grandmother" "girl friend") I am God. She kept screaming it at me all last night, \"OH GOD ${nick^^} DON'T STOP!\""
;;
*)
message="$(shuf -n1 -e "yes" "no" "maybe" "ask again later")."
esac
fi
msg "$chan" "$userNick: $message"
