#!/usr/bin/gawk -f
function printcalc(matrix, idx,
                   i, j, str) {
    str="0"
    for (i = 1; i <= NF; i++) {
        str = str "+(" ($i == "*" ? "1" : "0")
        for (j = 1; j < idx; j++)
            str = str $i matrix[j][i]
        str = str ")"
    }
    return str
}
BEGIN {
    idx = 1
}
{
    if ($1 == "*" || $1 == "+") {
        print printcalc(matrix, idx) | "bc"
    } else {
        split($0, matrix[idx++])
    }
}
