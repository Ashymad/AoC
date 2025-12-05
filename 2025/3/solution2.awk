#!/usr/bin/awk -f
BEGIN {
    FS=""
    num=12
}
{
    out = 0
    max_i = 0
    for (m = 1; m <= num; m++) {
        max = 0
        last_max_i = max_i
        for (i = m + NF - num; i > last_max_i; i--) {
            if ($i >= max) {
                max = $i
                max_i = i
            }
        }
        out += max*10^(num-m)
    }

    sum += out
}
END {
    print sum
}
