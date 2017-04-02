#!/bin/bash

[ -f functions.sh ] && source functions.sh
[ -f bot.cfg ] && source bot.cfg
input=".botinput"

close_bot()
{
  echo -en "QUIT :$quitMessage\r\n" >> "$input"
  rm "$input"
  exit 0
}

trap close_bot EXIT $?

echo "Session started $(date "+%I:%M%p%n    %A, %B %d, %Y")" | tee "$log" 
echo "NICK $nick" | tee "$input"
echo "USER $user" | tee -a "$input"
for c in ${channel[@]} ; do
  echo "JOIN #$c" | tee -a "$input"
  sleep 0.5
done

tail -f "$input" | telnet "$server" "$port" | while read result
do
  # log the session
  echo "$(date "+[$dateFormat]") $result" | tee -a "$log"
  # do things when you see output
  case "$result" in
    # respond to ping requests from the server
    PING*)
      echo "$result" | tee -a "$log"
      echo "${result/I/O}" | tee -a "$input"
    ;;
    # for pings on nick/user
    *"You have not"*)
      echo "JOIN #$channel" | tee -a "$input"
    ;;
    # run when someone joins
    *"JOIN :#"*)
      who="${result%%!*}"
      who="${who:1}"
      from="${result#*#}"
      from="#$from"
      if [ "$who" = "$nick" ]; then
       continue 
      fi
      echo "MODE #$channel +o $who" | tee -a "$input"
      if [ "${greet^^}" = "TRUE" ]; then
set -f        
./triggers/greet/greet.sh "$who" "$from"
set +f
      fi
    ;;
    # run when someone leaves
    *"PART #"*)
      who="${result%%!*}"
      who="${who:1}"
      from="${result#*#}"
      from="#$from"
      if [ "$who" = "$nick" ]; then
       continue 
      fi
      if [ "${leave^^}" = "TRUE" ]; then
set -f        
./triggers/bye/bye.sh "$who" "$from"
set +f
      fi
    ;;
    # run when a message is seen
    *PRIVMSG*)
      echo "$result" | tee -a "$log"
      who="${result%%!*}"
      who="${who:1}"
      from="${result#*#}"
      from="#${from%% *}"
      # Trigger stuff happens here.
      # Call link trigger if msg contains a link:
      if [[ "$result" =~ .*http://|https://|www\..* ]]; then
        ./triggers/link/link.sh "$who" "$from" "$result"
      # Although this calls modules, it triggers on text other than the bot's nick
      elif [[ "$result" =~ ^.*PRIVMSG.*:[[:punct:]].* ]]; then
        command="${result#*:[[:punct:]]}"
        command="${command//# /}"
        will="${command#* }"
        command="${command%% *}"
      if [ -z "$(ls modules/ | grep -i -- "$command")" ] || [ -z "$command" ]; then
        continue
      fi
# Disable wildcards
set -f      
./modules/${command% *}/${command% *}.sh "$who" "$from" $will
# Enable wildcards
set +f
      else
set -f
      ./triggers/keywords/keywords.sh "$who" "$from" "$result"
 set +f
      fi
      # "#" would mean it's a channel
      if [ "$(echo "$from" | grep '#')" ]; then
        test "$(echo "$result" | grep ":$nick:")" || continue
        will="${result#*#*:}"
        will="${will#*:}"
      else
        will="${result:1}"
        will="${will#* :}"
        from="$who"
      fi
      # Had to turn on globbing to remove all leading whitespace, then turn it off again afterwards.
      shopt -s extglob
      will="${will##*( )}"
      shopt -u extglob
      command="${will%% *}"
      will="${will#* }"
      if [ -z "$(ls modules/ | grep -i -- "$command")" ] || [ -z "$command" ]; then
set -f        
./modules/help/help.sh "$who" "$from"
set +f
        continue
      fi
set -f      
./modules/$command/$command.sh "$who" "$from" $will
set +f
    ;;
    *)
      echo "$result" | tee -a "$log"
    ;;
  esac
done
