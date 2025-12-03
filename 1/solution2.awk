#!/usr/bin/awk -f
BEGIN {
    dial=50
}
/^R/ {
    rot = substr($1,2)
    out = out + int((dial + rot)/100)
    dial = (dial + rot) % 100
}
/^L/ {
    rot = substr($1,2)
    out = out + int((((100 - dial) % 100) + rot)/100)
    dial = 99 + ((dial - 99 - rot) % 100)
}
END {
    print out
}
