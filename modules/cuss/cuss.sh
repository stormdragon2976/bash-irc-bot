[ -f functions.sh ] && source functions.sh

# Add phrases in quotes to the array.
phrases=(
  "cuss words, just let 'em roll, mother fucking shit god damn ass hole!"
  "damn!"
  "fuck the fucking fuckers!"
  "fuck!"
  "god damn it!"
  "motherfucker"
  "shit, piss, fuck, cunt, cocksucker, motherfucker, and tits."
  "shit!"
  "son of a bitch!"
)
msg "$2" "${phrases[$(($RANDOM % ${#phrases[@]}))]}"
