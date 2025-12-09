#!/usr/bin/gawk -f
function check(char) {
    return char == "S" || char == "|"
}
{
    FS=""
    slits=0
}
{
    if (NR == 1) {
        prev = $0
        print $0
    } else {
        line = ""
        for (i = 1; i <= NF; i++) {
            if ($(i+1) == "^" && check(substr(prev,i+1,1))) {
                splits++;
                line = line "|"
            } else if ($(i-1) == "^" && check(substr(prev,i-1,1))) {
                line = line "|"
            } else if ($i == "." && check(substr(prev,i,1))) {
                line = line "|"
            } else {
                line = line $i
            }
        }
        prev = line
        print line
    }
}
END {
    print splits
}
