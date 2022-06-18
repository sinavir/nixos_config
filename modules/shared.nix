{ config, lib, ... }:
{
  options.shared = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
  };
}

