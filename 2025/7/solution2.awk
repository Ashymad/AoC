#!/usr/bin/gawk -f
function check(char) {
    return char == "S" || char == "|"
}
BEGIN {
    FS=""
    timelines=0
}
{
    if (NR == 1) {
        prev = $0
        print $0
    } else {
        line = ""
        splits = 0
        for (i = 1; i <= NF; i++) {
            if ($(i+1) == "^" && check(substr(prev,i+1,1)) ||\
                $(i-1) == "^" && check(substr(prev,i-1,1)) ||\
                $i == "." && check(substr(prev,i,1))) {
                line = line "|"
            } else {
                line = line $i
            }
            if ($i == "^" && check(substr(prev,i,1)))
                timelines += 2
        }
        prev = line
        print line
    }
}
END {
    print timelines
}
