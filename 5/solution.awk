#!/usr/bin/gawk -f
function compare(v1, v2) {
    if (v1 < v2)
        return -1
    else if (v1 == v2)
        return 0
    else
        return 1
}
function compare_range_by_low(i1, v1, i2, v2) {
    return compare(v1[0], v2[0]);
}
function compare_range_by_high(i1, v1, i2, v2) {
    return -compare(v1[1], v2[1]);
}
function print_ranges(ranges,
                      r) {
    printf "[\n"
    for (r in ranges) {
        printf "  %s-%s,\n",ranges[r][0],ranges[r][1]
    }
    printf "]\n"
}

function find_in_ranges(ranges, val, sign, slot,
                        idx, len, divider, jump) {
    len = length(ranges)
    idx = int(len/2)+1
    printf "%s: %s[%s]",val,idx,ranges[idx][slot];
    for (divider = 2; int(len/divider) > 0; divider *= 2) {
        jump = sign*compare(ranges[idx][slot], val)*int(len/divider)
        printf " %s",jump
        if (idx + jump < 1 ||\
            idx + jump > len ||\
            ((jump*jump) == 1 && sign*ranges[idx + jump][slot] < sign*val))
            continue;
        idx += jump
        printf " %s[%s]",idx,ranges[idx][slot];
    }

    print ""
    return idx
}

BEGIN {
    FS="-"
    idx=0
}
{
    if ($0 == "") {
        idx=-1
        asort(ranges, lows, "compare_range_by_low");
        printf "L: "
        print_ranges(lows);
        asort(ranges, highs, "compare_range_by_high");
        printf "H: "
        print_ranges(highs);
    } else if (idx == -1) {
        found = find_in_ranges(lows, $1, -1, 0);
        if ($1 >= lows[found][0] && $1 <= lows[found][1]) {
            printf "%s in (%s, %s)\n",$1,lows[found][0],lows[found][1]
            sum++;
        } else {
            found = find_in_ranges(highs, $1, 1, 1);
            if ($1 >= highs[found][0] && $1 <= highs[found][1]) {
                printf "%s in (%s, %s)\n",$1,highs[found][0],highs[found][1]
                sum++;
            } else {
                printf "%s not found\n",$1
            }
        }
    } else {
        ranges[idx][0] = $1
        ranges[idx++][1] = $2
    }
}
END {
    print "TOTAL: " sum
}
