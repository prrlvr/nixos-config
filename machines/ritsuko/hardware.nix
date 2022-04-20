{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ ];
    extraModulePackages = [ ];
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
      };
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
