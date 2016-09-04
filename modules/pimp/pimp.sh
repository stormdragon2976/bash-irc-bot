[ -f functions.sh ] && source functions.sh

shift
chan="$1"
shift
pimpText="${@#pimp }"
msg "$chan" "$(curl -s --data-urlencode English="$pimpText" --data-urlencode submit="Submit send" http://joel.net/EBONICS/Translator | grep '                            <textarea id="Ebonics" name="Ebonics" class="materialize-textarea validate" required>' | sed -e 's/^                            <textarea id="Ebonics" name="Ebonics" class="materialize-textarea validate" required>//' -e "s/&#39;/'/g" -e 's#</textarea>##' -e 's/^$//g' -e 's/"/\\"/g')"
