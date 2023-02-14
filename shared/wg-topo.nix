{
  wg-main = {
    nets = [
      "10.100.1.1/24"
      "fdb9::/64"
    ];
    peers = {
      proxima = rec {
        port = "1194";
        Endpoint = "51.210.243.54:${port}";
        PublicKey = "7P1g+dD/EfJaKcqP4rn4mikdTVOafChyidvzEr4JbU0=";
        IPs = [
          "10.100.1.1/24"
          "fdb9::1/64"
        ];
        fullIPs = [
          "10.100.1.1/32"
          "fdb9::1/128"
        ];
      };
      algedi = rec {
        port = "1194";
        Endpoint = "rz.sinavir.fr:${port}";
        PublicKey = "jMWOkNl636QTSpHyZMuaXGMDXcakiUHUN1m8o4dA3z8=";
        IPs = [
          "10.100.1.2/24"
          "fdb9::2/64"
        ];
        fullIPs = [
          "10.100.1.2/32"
          "fdb9::2/128"
        ];
      };
    };
  };
}