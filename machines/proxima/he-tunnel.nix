# modprobe ipv6
# ip tunnel add he-ipv6 mode sit remote 216.66.84.42 local 51.210.243.54 ttl 255
# ip link set he-ipv6 up
# ip addr add 2001:470:1f12:d7::2/64 dev he-ipv6
# ip route add ::/0 dev he-ipv6
# ip -f inet6 addr
# https://gist.github.com/ne9z/fc81605ce3c2b2293b4a6043e278d122
