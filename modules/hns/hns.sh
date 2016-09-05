[ -f functions.sh ] && source functions.sh
cpu="$(shuf -n 1 -e HACKER NUKE SHOTGUN)"
player="$3"

case "${player^^}" in
  H|HA|HAC|HACK|HACKE|HACKER)
    player="HACKER"
  ;;
  N|NU|NUKE)
    player="NUKE"
  ;;
  S|SH|SHO|SHOT|SHOTG|SHOTGU|SHOTGUN)
    player="SHOTGUN"
  ;;
  *)
    player="INVALID"
esac

if [[ "$player" = "INVALID" ]]; then
msg "$2" "$1: Please select HACKER, NUKE, or SHOTGUN."
elif [[ "$cpu" = "$player" ]]; then
  msg "$2" "$1: You and I both selected $player, so we achieved mutual annihilation!"
elif [[ "$cpu" = "HACKER" && "$player" != "SHOTGUN" ]]; then
  msg "$2" "$1: my $cpu disarmed your $player! I win!"
elif [[ "$cpu" = "NUKE" && "$player" != "HACKER" ]]; then
  msg "$2" "$1: Never bring a $player to a fight with ${cpu}s! I blew your ass up! I win!"
elif [[ "$cpu" = "SHOTGUN" && "$player" != "NUKE" ]]; then
  msg "$2" "$1: my $cpu splattered your ${player}'s head all over the wall! Eww gross, look at the brain goo... I win!"
elif [[ "$player" = "HACKER" && "$cpu" != "SHOTGUN" ]]; then
  msg "$2" "$1: your $player disarmed my $cpu! You win!"
elif [[ "$player" = "NUKE" && "$cpu" != "HACKER" ]]; then
  msg "$2" "$1: Never bring a $cpu to a fight with ${player}s! You blew my ass up! You win!"
else
  msg "$2" "$1: your $player splattered my ${player}'s head all over the wall! Eww gross, look at the brain goo... You win!"
fi
