#!/bin/bash

EASYLIST_URL=https://easylist.to/easylist/easylist.txt
EASYLIST_DATA=$(curl -s ${EASYLIST_URL})

echo -n -- "${EASYLIST_DATA}" | grep -E '^\|\|' | grep -v -E '(\$|\^|\?)' | cut -c 3- | sed -E 's|/.*||' | sort -u | awk '{print $1 "\n*." $1}' | xargs | awk '{print "hostname = " $0}'
echo -n -- "${EASYLIST_DATA}" | grep -E '^\|\|' | grep -v -E '(\$|\^|\?)' | cut -c 3- | sed -E -e 's|/|\\/|g' -e 's|\.|\\.|g' | awk '{print "^https?:\\/\\/.*\\." $1 " url reject"}'
