[ -f functions.sh ] && source functions.sh

set -f

name="$1"
channelName="$2"
shift
shift

# Get the current weather information into a variable and stip all blank lines.
args="$@"
weather="$(curl -s http://wttr.in/${args//[[:space:]]/+}?T0 | sed '/^$/d')"

# Get the location
location="$(echo "$weather" | head -n1 | cut -f2 -d: | sed 's/^[[:space:]]//')"
# Strip location info from the weather variable
weather="${weather#*$'\n'}"

# Extract current conditions from the weather variable
conditions="${weather%*  }"
conditions="${conditions%%$'\n'*}"
conditions="${conditions##*  }"
# Remove conditions info from weather variable.
# Also remove everything after the next line because we only need the temperature info.
weather="${weather#*$'\n'}"
weather="${weather%%$'\n'*}"

# Get and format the temperature information from the weather variable.
temperature="${weather##*. }"
temperature="${temperature##*-}"
# Remove leading and trailing spaces.
temperature="$(echo "$temperature" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

# Show the weather information.
msg "$channelName" "$name: weather for ${location} is ${conditions} and ${temperature}."
set +f
