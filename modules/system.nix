{ config, inputs, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  networking.firewall.allowedTCPPorts = [ 22 ];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  hardware.bluetooth.enable = true;

  ##### KWALLET #####
  programs.kdeconnect.enable = true;
  security.pam.services.login.kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };
  environment.systemPackages = with pkgs; [
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
  ];

  #### Sops #####
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/nix/persist/var/lib/sops-nix/key.txt";

  sops.secrets.root-pass = { };
  sops.secrets.kybe-pass = { };
  sops.secrets.root-pass.neededForUsers = true;
  sops.secrets.kybe-pass.neededForUsers = true;

  ##### Users #####
  users.mutableUsers = false;
  users.users.root = {
    hashedPasswordFile = config.sops.secrets.root-pass.path;
  };
  users.users.kybe = {
    isNormalUser = true;
    description = "2kybe3";
    shell = pkgs.zsh;
    extraGroups = [ 
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7irWuDZwx7ZvPSiUwBbxUxKL/7aMQmy/8oxput1bID kybe@khost"
    ];
    hashedPasswordFile = config.sops.secrets.kybe-pass.path;
  };

  ##### Nix Settings #####
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ##### Boot loader #####
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##### Services #####
  services.dbus.enable = true;
  services.printing.enable = true;
  services.mullvad-vpn.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "kybe" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "yes";
    };
  };
}
