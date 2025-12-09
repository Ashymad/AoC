#!/usr/bin/gawk -f
function compare(i1, v1, i2, v2) {
    return v1[0] == v2[0] ? 0 : (v1[0] < v2[0] ? -1 : 1)
}
function consolidate(ranges,
                     i, idx, len) {
    len = length(ranges)
    idx = 1
    for (i = 2; i <= len; i++) {
        if (ranges[i][0] <= ranges[idx][1] + 1) {
            if (ranges[i][1] > ranges[idx][1]) {
                ranges[idx][1] = ranges[i][1]
            }
        } else if (++idx != i) {
            ranges[idx][0] = ranges[i][0]
            ranges[idx][1] = ranges[i][1]
        }
        if (idx != i)
            delete ranges[i]
    }
}
                        
BEGIN {
    FS="-"
    idx=0
}
{
    if ($0 == "") {
        asort(ranges, ranges, "compare");
        consolidate(ranges);
        for (i in ranges) {
            sum += 1 + ranges[i][1] - ranges[i][0]
        }
        print sum
        exit 0
    } else {
        ranges[idx][0] = $1
        ranges[idx++][1] = $2
    }
}
