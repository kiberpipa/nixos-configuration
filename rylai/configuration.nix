# the system.  Help is available in the configuration.nix(5) man page
# or the NixOS manual available on virtual console 8 (Alt+F8).

{ config, pkgs, ... }:

{
  require =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.initrd.kernelModules =
    [ # Specify all kernel modules that are necessary for mounting the root
      # filesystem.
      # "xfs" "ata_piix"
    ];

  boot.kernelPackages = pkgs.linuxPackages_3_7;
    
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Define on which hard drive you want to install Grub.
 
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "rylai"; # Define your hostname.
  networking.wireless.enable = false;  # Enables Wireless.

  # Add filesystem entries for each partition that you want to see
  # mounted at boot time.  This should include at least the root
  # filesystem.

  fileSystems."/" =     # where you want to mount the device
   { device = "/dev/sda2";  # the device
     fsType = "ext4";      # the type of the partition
   };

  # List swap partitions activated at boot time.
  swapDevices =
    [ { device = "/dev/sda3"; }
    ];

  # Select internationalisation properties.
  i18n = { consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    htop
    screen
    unrar
    unzip
    wget
    rtorrent
    xchat
    ncftp
    filezilla
    vlc
    chromiumWrapper
    firefoxWrapper
    libreoffice
    gimp_2_8
    blender
    inkscape
    audacity
    cinelerra
    ncmpcpp
    vim
    joe
    gitFull
  ];
  # List services that you want to enable:

  services.nixosManual.showManual = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable audio
  services.pulseaudio.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
   enable = true;
   layout = "sl";
   xkbOptions = "eurosign:e";
   displayManager.slim = {
    enable = true;
    defaultUser = "arhivar";
    autoLogin = true;
   }; 
   desktopManager.default = "xfce";
   desktopManager.xfce.enable = true;
  };
}
