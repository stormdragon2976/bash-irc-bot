[ -f functions.sh ] && source functions.sh
output="$1: The modules I have are:"
output="$output $(find modules/ -type d | tr '[:space:]' ' ' | sed -e 's#modules/##g')"
msg "$2" "$output"
