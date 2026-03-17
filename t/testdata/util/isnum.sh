# isnum.sh
# Test _tap_isnum
# By J. Stuart McMurray
# Created 20260317
# Last Modified 20260317

. ./t/t.subr
. ./shmore.subr

for HAVE in \
        "   " \
        " 123 " \
        "" \
        "kittens moose" \
        0 \
        100 \
        kittens \
        '
'
do
        echo "$HAVE - $(
                if _tap_isnum "$HAVE"; then
                        echo "yes"
                else
                        echo "no"
                fi
        )"
done
