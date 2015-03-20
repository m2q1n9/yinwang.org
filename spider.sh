#!/usr/bin/env bash

cp -f index_html index.html
rm -fr blog-cn && mkdir blog-cn

REGEXP=".*\/\(yinwang.org\/\(blog-cn\/.*\)\/\(.*\)\/\(.*\)\/.*\)\\\">\(.*\)<.*"
wget yinwang.org -O -|\
sed -n "/$REGEXP/p" | sed "s/$REGEXP/\1|\2-\3-\4|\5/g" |\
gawk -F '|' '{ h=""$2" "$3".html"; c="\
wget "$1" -O \""h"\";\
echo \"<li><a href=\\\""h"\\\">"$3"</a></li>\">>index.html\
"; print c; system(c) }'
echo "<br/></body></html>">>index.html
