# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "sr_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/29632002-558e-4686-a0d1-34eb7819e929";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."mainfs".device = "/dev/disk/by-uuid/0bd690f5-0ab8-41ed-93b8-0d7baf267165";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/29632002-558e-4686-a0d1-34eb7819e929";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/DF12-3EF3";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/29632002-558e-4686-a0d1-34eb7819e929";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
