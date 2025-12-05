#!/usr/bin/gawk -f
function process(end) {
    sum = 0;

    for (i = 0; i <= NF; i++) {
        lines[0][i+1] = end ? "" : $(i+1)

        for (j = 3; j > 0; j--) {
            lines[j][i+1] = lines[j-1][i+1]
            sum += (lines[j][i+1] == "@") - (lines[j][i-2] == "@")
        }
        if (lines[2][i] == "@" && sum < 5) {
            out = out "."
            total++;
        } else {
            out = out (lines[2][i])
        }
    }
    if (lines[2][1] != "") out = out "\n"
}

BEGIN {
    FS=""
}
{
    process(0)
}
END {
    process(1)
    if (total == 0) {
        print prevtot
    } else {
        printf "%s", out | "gawk -v prevtot=" (prevtot+total) " -f ./solution2.awk"
    }
}
