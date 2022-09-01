# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b0cc0efd-b8eb-4301-9d79-3402a3207119";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."main".device = "/dev/disk/by-uuid/8105547a-f3c6-4eba-9d5b-ab5f8b6421d9";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4806-C3C7";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a7a71cb5-2f81-4690-bb0a-0a4758794e3f"; }
    ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
