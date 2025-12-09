#!/usr/bin/gawk -f
function calc(lines,
              i, j, l, digit) {
    out = "0"
    for (i = 1; i <= NF; i += (l+1)) {
        out = sprintf("%s+(%s", out, $i == "*" ? 1 : 0)
        for (l = 0; $(i+l+1) == " " || i+l == NF; l++) {
            out = out $i
            for (j in lines) {
                digit = substr(lines[j],i+l,1)
                if (digit != " ")
                    out = out digit
            }
        }
        out = out ")"
    }
    return out
}
{
    FS=""
}
{
    if ($1 == "*" || $1 == "+") {
        print calc(lines) | "bc"
    } else {
        lines[NR]=$0
    }
}
