# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/iso" =
    { device = "/dev/disk/by-uuid/1980-01-01-00-00-00-00";
      fsType = "iso9660";
    };

  fileSystems."/nix/.rw-store" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/nix/store" =
    { device = "overlay";
      fsType = "overlay";
    };

  fileSystems."/nix/store" =
    { device = "/nix/store";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/mnt" =
    { device = "/dev/disk/by-uuid/f7a666ea-dc06-443e-aab7-f4f7b5ff6b87";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/mnt/nix/store" =
    { device = "/dev/disk/by-uuid/f7a666ea-dc06-443e-aab7-f4f7b5ff6b87";
      fsType = "btrfs";
      options = [ "subvol=nixstore" ];
    };

  fileSystems."/mnt/boot" =
    { device = "/dev/disk/by-uuid/46E2-9994";
      fsType = "vfat";
    };

  swapDevices = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
