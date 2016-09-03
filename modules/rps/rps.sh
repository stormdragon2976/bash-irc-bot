[ -f functions.sh ] && source functions.sh
cpu="$(shuf -n 1 -e PAPER ROCK SCISSORS)"
player="$3"

case "${player^^}" in
  R|RO|ROC|ROCK)
    player="ROCK"
  ;;
  P|PA|PAP|PAPE|PAPER)
    player="PAPER"
  ;;
  S|SC|SCI|SCIS|SCISS|SCISSO|SCISSOR|SCISSORS)
    player="SCISSORS"
  ;;
  *)
    player="INVALID"
esac

if [[ "$player" = "INVALID" ]]; then
msg "$2" "$1: Please select PAPER, ROCK, or SCISSORS."
elif [[ "$cpu" = "$player" ]]; then
  msg "$2" "$1: You and I both selected $player, so we tied."
elif [[ "$cpu" = "PAPER" && "$player" != "SCISSORS" ]]; then
  msg "$2" "$1: my $cpu beats your $player!"
elif [[ "$cpu" = "ROCK" && "$player" != "PAPER" ]]; then
  msg "$2" "$1: my $cpu beats your $player!"
elif [[ "$cpu" = "SCISSORS" && "$player" != "ROCK" ]]; then
  msg "$2" "$1: my $cpu beats your $player!"
elif [[ "$player" = "PAPER" && "$cpu" != "SCISSORS" ]]; then
  msg "$2" "$1: your $player beats my $cpu!"
elif [[ "$player" = "ROCK" && "$cpu" != "PAPER" ]]; then
  msg "$2" "$1: your $player beats my $cpu!"
else
  msg "$2" "$1: your $player beats my $cpu!"
fi
