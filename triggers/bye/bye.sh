[ -f functions.sh ] && source functions.sh
# All names to match are completely lowercase.
case "${1,,}" in
storm_dragon)
msg "$2" "NOOOOOOOOOO!!! $1: come back!!!"
;;
*)
bye=(
  "Bye $1." 
  "Alas $1, you will be missed."
)
msg "$2" "$1: ${bye[$(($RANDOM % ${#bye[@]}))]}"
esac
