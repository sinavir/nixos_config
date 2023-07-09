{ lib, ... }: {
  # TODO: Switch to networkd
  networking.useDHCP = lib.mkDefault true;
}
