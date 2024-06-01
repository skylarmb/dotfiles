# Edit this configuration file to define what should be installed on your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./apple-silicon-support
      <home-manager/nixos>
    ];

  # Boot 
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false; 
    };
    consoleLogLevel = 0;
    kernelParams = [ "apple_dcp.show_notch=1" ];
  };

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set time zone.
  time.timeZone = "America/Los_Angeles";

  # Enable graphical desktop environment 
  services.xserver.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = lib.mkForce false;
  };
  hardware.asahi = {
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    setupAsahiSound = true;
    withRust = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  }; 

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable local fonts

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
   ];
 
  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define user account.
  users.users.skylar = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  home-manager.users.skylar = { pkgs, ... }: {
    home.packages = [ ];
    # programs.bash.enable = true;
    # programs.zsh = {
    #   enable = true;
    #   oh-my-zsh = {
    #     enable = true;
    #   };
    # };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.05";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs._1password-gui.enable = true;
  programs.zsh.enable = true;
  
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    firefox
    neovim
    alacritty
    wofi
    wl-clipboard
    gcc
    git
    eza
    bat
    tmux
    nodejs
    ripgrep
    fzf
    unzip
    delta
    gh
    libsForQt5.bismuth
    hyprpaper
    libnotify
    swaynotificationcenter
    brightnessctl
    cliphist
    clipman
    wtype
  ];
  

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes"]; 
  
  # Do NOT change this value
  system.stateVersion = "24.05"; # Did you read the comment?
}

