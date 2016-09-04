#!/bin/bash

[ -f functions.sh ] && source functions.sh
[ -f bot.properties ] && source bot.properties
input=".bot.cfg"
echo "Starting session: $(date "+[%y:%m:%d %T]")" | tee  $log 
echo "NICK $nick" > $input 
echo "USER $user" >> $input
for c in ${channel[@]} ; do
  echo "JOIN #$c" | tee -a $input
done

tail -f $input | telnet $server $port | while read res
do
  # log the session
  echo "$(date "+[%y:%m:%d %T]")$res" | tee -a $log
  # do things when you see output
  case "$res" in
    # respond to ping requests from the server
    PING*)
      echo "$res" | sed "s/I/O/" >> $input 
    ;;
    # for pings on nick/user
    *"You have not"*)
      echo "JOIN #$channel" >> $input
    ;;
    # run when someone joins
    *"JOIN #"*)
      who=$(echo "$res" | perl -pe "s/:(.*)\!.*@.*/\1/")
      chan="$(echo "$res" | cut -d '#' -f2)"
      chan="#$chan"
      if [ "$who" = "$nick" ]; then
       continue 
      fi
      echo "MODE #$channel +o $who" >> $input
      [ "${greet^^}" = "TRUE" ] && ./triggers/greet/greet.sh $who $chan
    ;;
    # run when someone leaves
    *"PART #"*)
      who=$(echo "$res" | perl -pe "s/:(.*)\!.*@.*/\1/")
      chan="$(echo "$res" | cut -d '#' -f2)"
      chan="#$chan"
      if [ "$who" = "$nick" ]; then
       continue 
      fi
      echo "MODE #$channel +o $who" >> $input
      [ "${leave^^}" = "TRUE" ] && ./triggers/bye/bye.sh $who $chan
    ;;
    # run when a message is seen
    *PRIVMSG*)
      echo "$res"
      who=$(echo "$res" | perl -pe "s/:(.*)\!.*@.*/\1/")
      from=$(echo "$res" | perl -pe "s/.*PRIVMSG (.*[#]?([a-zA-Z]|\-)*) :.*/\1/")
      # This looks to be the spot where triggers should be called
      # Call link trigger if msg contains a link:
      if [[ "$res" =~ .*http://|https://|www\..* ]]; then
        ./triggers/link/link.sh "$who" "$from" "$res"
      # Although this calls modules, it triggers on text other than the bot's nick
      elif [[ "$res" =~ .*$from\ :$who:$triggers.* ]]; then
        com"${res#*$from :$who:$triggers}"
      if [ -z "$(ls modules/ | grep -i -- "${com%* }")" ] || [ -z "$com" ]; then
        ./modules/help/help.sh $who $from
        continue
      fi
      ./modules/${com% *}/${com% *}.sh $who $from "${com#* }"
      fi
      # "#" would mean it's a channel
      if [ "$(echo "$from" | grep '#')" ]; then
        test "$(echo "$res" | grep ":$nick:")" || continue
        will=$(echo "$res" | perl -pe "s/.*:$nick:(.*)/\1/")
      else
        will=$(echo "$res" | perl -pe "s/.*$nick :(.*)/\1/")
        from=$who
      fi
      will=$(echo "$will" | perl -pe "s/^ //")
      com=$(echo "$will" | cut -d " " -f1)
      if [ -z "$(ls modules/ | grep -i -- "$com")" ] || [ -z "$com" ]; then
        ./modules/help/help.sh $who $from
        continue
      fi
      ./modules/$com/$com.sh $who $from $(echo "$will" | cut -d " " -f2-99)
    ;;
    *)
      chan="$(echo "$res" | cut -d '#' -f2)"
      chan="#$chan"
      echo "$res"
    ;;
  esac
done
