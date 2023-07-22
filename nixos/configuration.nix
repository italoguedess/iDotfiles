# Repository and hardware configuration

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

# Bootloader, networking and timezone/locale

# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
networking.networkmanager.enable = true;
programs.nm-applet.enable = true;

  # Set your time zone.
time.timeZone = "America/Fortaleza";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

i18n.extraLocaleSettings = {
  LC_ADDRESS = "pt_BR.UTF-8";
  LC_IDENTIFICATION = "pt_BR.UTF-8";
  LC_MEASUREMENT = "pt_BR.UTF-8";
  LC_MONETARY = "pt_BR.UTF-8";
  LC_NAME = "pt_BR.UTF-8";
  LC_NUMERIC = "pt_BR.UTF-8";
  LC_PAPER = "pt_BR.UTF-8";
  LC_TELEPHONE = "pt_BR.UTF-8";
  LC_TIME = "pt_BR.UTF-8";
};

# Display manager and Desktop environments/WMs

# Enable the X11 windowing system.
services.xserver.enable = true;

# Enabling sddm as the display manager
services.xserver.displayManager.sddm.enable = true;
# Plasma desktop
services.xserver.desktopManager.plasma5.enable = false;
# i3-gaps-rounded
services.xserver.windowManager.i3.enable = true;
services.xserver.windowManager.i3.package = pkgs.i3-rounded;

# Keymap

# Configure keymap in X11
services.xserver = {
  layout = "br";
  xkbVariant = "";
};

# Configure console keymap
console.keyMap = "br-abnt2";

# Printing and audio stuff

# Enable CUPS to print documents.
services.printing.enable = true;

# Enable sound with pipewire.
sound.enable = true;
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;
};

# Touchpad

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# User account and packages

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.user = {
  isNormalUser = true;
  description = "user";
  extraGroups = [ "networkmanager" "wheel" ];
  packages = with pkgs; [
    vim 
    emacs
    polybarFull
    redshift
    git
    kitty
    brave
    rofi
    picom
    htop
  ];
};

# Auto login

# Enable automatic login for the user.
# services.xserver.displayManager.autoLogin.enable = true;
# services.xserver.displayManager.autoLogin.user = "user";

# Unfree, system and font packages

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
];

# adding some fonts
fonts.fonts = with pkgs; [
  nerdfonts
  jetbrains-mono
];

# SUID, OpenSSH daemon and firewall

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

# System version

# This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
