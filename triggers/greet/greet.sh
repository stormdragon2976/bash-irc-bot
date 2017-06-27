[ -f functions.sh ] && source functions.sh
# All names to match are completely lowercase.
case "${1,,}" in
storm_dragon)
msg "$2" "my lord, $1: how may I serve you?"
;;
*)
greeting=(
  Greetings
  "Howdy, welcome to $2!"
  "Wazzup Moe Fugger!"
  "Welcome to $2!"
)
msg "$2" "$1: ${greeting[$(($RANDOM % ${#greeting[@]}))]}"
esac
