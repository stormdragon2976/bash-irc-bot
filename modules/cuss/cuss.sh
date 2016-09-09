[ -f functions.sh ] && source functions.sh

# Add phrases in quotes to the array.
phrases=(
  "cuss words, just let 'em roll, mother fucking shit god damn ass hole!"
  "cuss words, just don't quit, mother fuck you damn shit head bitch!"
  "damn!"
  "fuck the fucking fuckers!"
  "fuck the fuck off!"
  "fuck!"
  "fuck. fuck. fuck. Mother mother fuck. Mother mother fuck fuck. Mother fuck mother fuck. Noise noise noise."
  "god damn it!"
  "motherfucker"
  "shit, piss, fuck, cunt, cocksucker, motherfucker, and tits."
  "shit!"
  "son of a bitch!"
)
msg "$2" "${phrases[$(($RANDOM % ${#phrases[@]}))]}"
