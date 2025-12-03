#!/usr/bin/awk -f
BEGIN {
    dial=50
}
/^R/ {
    dial = (dial + substr($1,2)) % 100
}
/^L/ {
    dial = 99 + ((dial - 99 - substr($1,2)) % 100)
}
{
    if (dial == 0) out++
}
END {
    print out
}
