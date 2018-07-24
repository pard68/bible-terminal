#!/bin/bash
curl -s https://ebible.org/engwebp/${1^^}$2.htm | 
sed -e "s/<div class='mt[ 0-9]*'>[^<]*//g" \
	-e 's/<span class="verse" id="V[0-9]*">[0-9]*&#[0-9]*;<\/span>/\n\n/g' \
	-e 's/<a href="#FN[0-9]*" class="notemark">.<[^>]*>[^<]*<\/span><\/a>//g' \
	-e 's/<a href=[^>]*>[^<]*<\/a>//g' \
	-e 's/<span class="notemark">[^<]*//g' \
	-e 's/<a class="notebackref"[^>]*>[^<]*//g' \
	-e 's/<span class="ft">[^<]*//g' \
	-e '/^div class="copyright">$/,$ d' \
	-e 's/<[^>]*>//g' \
	-e 's/ [ ]*/ /g' \
	-e 's///g' |
awk 'NR==1,/ [0-9] /{sub(/ [0-9] /, "")} 1' |
awk '{$1=$1}1' |
awk 't || !/^$/; { t = !/^$/ }' |
awk 'NR > 2 { print }'
