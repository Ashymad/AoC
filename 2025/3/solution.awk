#!/usr/bin/awk -f
BEGIN {
    FS=""
}
{
    delete max

    for (i = 1; i <= NF; i++) {
        if ($i > max[1]) {
            max[0] = max[1]
            max[1] = $i
            max[2] = 0
        } else if ($i > max[2]) {
            max[2] = $i
        }
    }

    if (max[2] == 0) {
        max[2] = max[1]
        max[1] = max[0]
    }

    sum += max[1] * 10 + max[2]
}
END {
    print sum
}
