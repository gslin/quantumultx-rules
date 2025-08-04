#!/bin/bash

JKGTW_LINEP_URL=https://raw.githubusercontent.com/jkgtw/Surge/master/Modules/LINE-ADs.sgmodule
JKGTW_LINE_DATA=$(curl -s ${JKGTW_LINEP_URL} | grep -E '^URL-REGEX,')

echo "# 0.$(date +%Y%m%d.%H%M%S)"
echo "#"
echo "# Line"

# Output MITM hostnames.
echo -n 'hostname = '
(
    sed -E \
        -e 's@^URL-REGEX,@@' \
        -e 's@,REJECT(-[A-Z]+)?$@@' \
        -e 's@^"https:\\/\\/(.*)"@\1@' \
        -e 's@^\^https:\\/\\/@@' \
        -e 's@\\/.*@@' \
        -e 's@\\@@g' | \
        env -i sort -u | xargs -d '\n'
) <<< "${JKGTW_LINE_DATA}"

# Output rules.
(
    sed -E \
        -e 's@^URL-REGEX,@@' \
        -e 's@^"(.*)"@\1@' \
        -e 's@,REJECT$@ url reject@' \
        -e 's@,REJECT-DROP$@ url reject@' \
        -e 's@,REJECT-TINYGIF$@ url reject-img@' | \
        env -i sort
) <<< "${JKGTW_LINE_DATA}"
