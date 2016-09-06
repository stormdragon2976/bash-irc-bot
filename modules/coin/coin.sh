[ -f functions.sh ] && source functions.sh

case "${3^^}" in
D|DI|DIM|DIME)
coin="dime"
;;
D|DO|DOL|DOLL|DOLLA|DOLLAR)
coin="silver dollar"
;;
H|HA|HAL|HALF|HALF-|HALF-D|HALF-DO|HALF-DOL|HALF-DOLL|HALF-DOLLA|HALF-DOLLAR)
coin="fifty-cent piece"
;;
N|NI|NICNICK|NICKE|NICKEL)
coin="nickel"
;;
P|PE|PEN|PENN|PENNY)
coin="penny"
;;
Q|QU|QUA|QUAR|QUART|QUARTER)
coin="quarter"
;;
*)
coin="$(shuf -n1 -e dime "fifty-cent piece" nickel penny "silver dollar" quarter)"
esac
catch="$(shuf -n1 -e true false)"
flip="$(shuf -n1 -e HEADS TAILS)"

message="pulls a $coin out, flips it high into the air,"
if [ "$catch" = "true" ]; then
message="$message and deftly catches it,"
else
message="$message and tries to grab it on the way back down but misses. After lots of cussin', tobaccer juce spittin' and searching, the $coin is found,"
fi
message="$message revealing $flip!"
act "$2" "$message"
