#!/bin/bash

JKGTW_LINEP_URL=https://raw.githubusercontent.com/jkgtw/Surge/master/Modules/LINE-ADs.sgmodule
JKGTW_LINE_DATA=$(curl -s ${JKGTW_LINEP_URL} | grep -E '^URL-REGEX,')

echo '# Line'

# Output MITM hostnames.
echo -n 'hostname = '
(
    sed -E \
        -e 's/^URL-REGEX,//' \
        -e 's/,REJECT(-[A-Z]+)?$//' \
        -e 's@^\^https:\\/\\/@@' \
        -e 's@\\/.*@@' \
        -e 's/\\//g' | \
        env -i sort -u | xargs
) <<< "${JKGTW_LINE_DATA}"

# Output rules.
(
    sed -E \
        -e 's/^URL-REGEX,//' \
        -e 's/,REJECT$/ url reject/' \
        -e 's/,REJECT-DROP$/ url reject/' \
        -e 's/,REJECT-TINYGIF$/ url reject-img/' | \
        env -i sort
) <<< "${JKGTW_LINE_DATA}"
