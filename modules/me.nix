{ config, lib, ... }:
{
  options.me = {
    lan = {
      ipv4 = lib.mkOption {
        type = lib.types.str;
      };
      ipv6 = lib.mkOption {
        type = lib.types.str;
      };
      prefixSize4 = lib.mkOption {
        type = lib.types.int;
      };
      prefixSize4 = lib.mkOption {
        type = lib.types.int;
      };
    };
  };
}
