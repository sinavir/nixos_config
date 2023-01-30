{ config, pkgs, lib, ... }:
{
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
}
