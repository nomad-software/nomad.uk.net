#!/bin/bash

find ./markdown/articles -iname "*.md" -print0 | while read -d $'\0' file
do
	LONG=$file;
	SHORT=$(echo ${LONG} | sed -E "s/^\.\/markdown\/(.*)\.md/\1/");
	URL="http://nomad.uk.net/${SHORT}.html";
	ID=$(echo ${URL} | md5sum | cut -d ' ' -f 1);

	pandoc --standalone \
		--template="templates/article.html" \
		--output="./${SHORT}.html" \
		--variable=disqus-url:${URL} \
		--variable=disqus-id:${ID} \
		${LONG};
done

find ./markdown/pages -iname "*.md" -print0 | while read -d $'\0' file
do
	LONG=$file;
	SHORT=$(echo ${LONG} | sed -E "s/^\.\/markdown\/(.*)\.md/\1/");
	URL="http://nomad.uk.net/${SHORT}.html";
	ID=$(echo ${URL} | md5sum | cut -d ' ' -f 1);

	pandoc --standalone \
		--template="templates/article.html" \
		--output="./${SHORT}.html" \
		--variable=disqus-url:${URL} \
		--variable=disqus-id:${ID} \
		${LONG};
done

pandoc --standalone --template="templates/article.html" --output="./index.html" "./markdown/index.md";
