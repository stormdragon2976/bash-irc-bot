[ -f functions.sh ] && source functions.sh
# All names to match are completely lowercase.
case "${1,,}" in
storm_dragon)
msg "$2" "my lord, $1: how may I serve you?"
;;
*)
greeting=(
  Greetings   
Howdy
  "Wazzup Moe Fugger!"
  Welcome
)
msg "$2" "$1: ${greeting[$(($RANDOM % ${#greeting[@]}))]}"
esac
