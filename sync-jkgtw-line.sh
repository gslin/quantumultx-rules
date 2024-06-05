#!/bin/bash

JKGTW_LINEP_URL=https://raw.githubusercontent.com/jkgtw/Surge/master/Modules/LINE-ADs.sgmodule
JKGTW_LINE_DATA=$(curl -s ${JKGTW_LINEP_URL} | grep -E '^URL-REGEX,')

echo '# Line'
echo -n 'hostname = '

(
    sed -E \
        -e 's/^URL-REGEX,//' \
        -e 's/,REJECT(-DROP)?$//' \
        -e 's@^\^https:\\/\\/@@' \
        -e 's@\\/.*@@' \
        -e 's/\\//g' | \
        env -i sort -u | xargs
) <<< "${JKGTW_LINE_DATA}"

(
    sed -E \
        -e 's/^URL-REGEX,//' \
        -e 's/,REJECT(-DROP)?$//' \
        -e 's/$/ url reject/' | \
        env -i sort
) <<< "${JKGTW_LINE_DATA}"
