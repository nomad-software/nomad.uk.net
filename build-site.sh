#!/bin/bash

find ./docs -iname "*.html" -exec rm -v {} \;

find ./markdown -iname "*.md" -print0 | while read -d $'\0' file
do
	LONG=$file;
	SHORT=$(echo ${LONG} | sed -E "s/^\.\/markdown\/(.*)\.md/\1/");
	URL="http://nomad.uk.net/${SHORT}.html";
	ID=$(echo ${URL} | md5sum | cut -d ' ' -f 1);

	mkdir -p ./docs/$(dirname ${SHORT});

	if [[ ${SHORT} =~ ^(index|pages/errors/404)$ ]]
	then
		pandoc \
			--wrap=none \
			--standalone \
			--template="templates/default.html" \
			--output="./docs/${SHORT}.html" \
			${LONG};
	else
		pandoc \
			--wrap=none \
			--standalone \
			--template="templates/default.html" \
			--output="./docs/${SHORT}.html" \
			--variable=disqus-url:${URL} \
			--variable=disqus-id:${ID} \
			${LONG};
	fi;

	echo "created './docs/${SHORT}.html'";
done;
