#!/bin/bash

find ./public -iname "*.html" -exec rm -v {} \;

find ./markdown -iname "*.md" -print0 | while read -d $'\0' file
do
	LONG=$file;
	SHORT=$(echo ${LONG} | sed -E "s/^\.\/markdown\/(.*)\.md/\1/");
	URL="http://nomad.uk.net/${SHORT}.html";
	ID=$(echo ${URL} | md5sum | cut -d ' ' -f 1);

	mkdir -p ./public/$(dirname ${SHORT});

	if [[ ${SHORT} =~ ^(index|pages/errors/404)$ ]]
	then
		pandoc --standalone \
			--template="templates/default.html" \
			--output="./public/${SHORT}.html" \
			${LONG};
	else
		pandoc --standalone \
			--template="templates/default.html" \
			--output="./public/${SHORT}.html" \
			--variable=disqus-url:${URL} \
			--variable=disqus-id:${ID} \
			${LONG};
	fi;

	echo "created './public/${SHORT}.html'";
done;
