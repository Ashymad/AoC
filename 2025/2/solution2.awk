#!/usr/bin/awk -f
BEGIN {
    RS=","
    FS="[-\n]"
}
{
    delete seen

    for (n = 1; (s_start = n*(10^length(n))+n) <= $2; n++) {
        for (s = s_start; s <= $2; s = s*(10^length(n))+n)
            if (s >= $1 && !seen[s]++)
                sum += s;
    }
}
END {
    print sum
}
