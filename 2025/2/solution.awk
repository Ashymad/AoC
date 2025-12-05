#!/usr/bin/awk -f
BEGIN {
    RS=","
    FS="[-\n]"
}
{
    l=int(length($1)/2)
    if (length($1) % 2 == 0)
        n = substr($1,1,l)
    else
        n = 10^l;
    while (1) {
       serial = n*(10^length(n))+(n++);

       if (serial <= $2) {
           if (serial >= $1)
               sum = sum + serial
       } else break;
   }
}
END {
    print sum
}
