#!/bin/bash                                                                                                                   
readonly ORG_FILES="Autotools.org autoconf.org automake.org"
readonly HTMLIZE=./docs/htmlize.el


# Download the htmlize Emacs plugin if not present
url="https://github.com/hniksic/emacs-htmlize"
repo="emacs-htmlize"

if [[ ! -f "${HTMLIZE}" ]]
then
    git clone ${url} \
        && cp ${repo}/htmlize.el ${HTMLIZE} \
        && rm -rf ${repo}
fi

# Assert htmlize is installed
[[ -f ${HTMLIZE} ]] \
    || exit 1


# Convert org to HTML
if [[ -f ./docs/htmlize.el ]]
then
    for org in ${ORG_FILES}
    do
	echo "HTMLIZE: $org"
    	emacs --batch --load ./docs/htmlize.el --load ./docs/config.el $org -f org-html-export-to-html
    done
else
    for org in ${ORG_FILES}
    do
	echo "CONVERT: $org"
    	emacs --batch --load ./docs/config.el $org -f org-html-export-to-html
    done
fi

mv Autotools.html docs/index.html
mv autoconf.html automake.html docs/
mv autotools.png docs/

