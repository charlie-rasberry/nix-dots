# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nero"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
    #useXkbConfig = true;
  };

  # Enable the X11 windowing system.

  services.xserver = {
    enable = true;
    };

  services.xserver.windowManager.qtile.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pulseaudio = {
  enable = true;
  package = pkgs.pulseaudioFull;
  support32Bit = true;
  extraConfig = ''
    # Disable/unload speaker sink
    unload-module module-alsa-card
    load-module module-alsa-card device_id=0 name=sof-essx8336 card_name=sof-essx8336 namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1"
    set-sink-port alsa_output.pci-0000_00_1f.3-platform-sof-essx8336.HiFi__Headphones__sink "[Out] Headphones"
  '';
};

  services.pipewire = {
    enable = false;
  };

  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true; 

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rasa = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio"] ;
    packages = with pkgs; [
      tree
    ];
  };
  

  environment.variables = {
  GTK_THEME = "Adwaita-dark";
  XCURSOR_THEME = "Bibata-Modern-Classic";
  QT_QPA_PLATFORMTHEME = "gtk2"; # Makes Qt apps follow GTK theme
  XDG_CURRENT_DESKTOP = "qtile"; # Helpful for some apps
  };

  xdg.icons.enable = true;

  
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.firefox.enable = true;
  
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    python310
    python313
    python313Packages.qtile
    kitty
    vscode
    gh
    conda
    gedit
    xdg-utils
    seahorse
    gnome-keyring
    nss			# watch these
    nspr
    libsecret


    gnome-themes-extra     
    papirus-icon-theme             
    bibata-cursors                  
    lxappearance

    brave
    thunderbird
    neovim
    firefox-devedition

    xorg.xinit
    neofetch
    picom
    asciiquarium-transparent
    
    vlc
    nomacs
    rofi
    feh
    xclip
    ksnip
    xfce.thunar
    gvfs
    libmtp
    android-file-transfer
    kdePackages.ark
    p7zip
    zip
    unzip
    unrar

    networkmanagerapplet
    fish

    pulseaudio
    pavucontrol
    alsa-utils
    pciutils
    alsa-firmware
    sof-firmware

    spotify

    brightnessctl

    rnote


];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

