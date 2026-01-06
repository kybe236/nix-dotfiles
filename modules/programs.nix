{ system, inputs, pkgs, ... }:
{
  # https://search.nixos.org/ https://mynixos.com/
  environment.systemPackages = with pkgs; [
    ## Netowrking
    wget
    curl
    mtr # traceroute + ping tool

    ## Editors
    vscodium

    ## Apps
    spotify
    (inputs.nixpkgs-vesktop.legacyPackages.${system}.vesktop)

    ## CLI
    speedtest-cli
    fastfetch
    pamixer # pulseaudio command line mixer
    ripgrep # Fast file search
    openssl # Provides some usefull stuff (openssl rand -hex <length>, etc.)
    psmisc # killall etc.
    unzip
    file
    sops # secrets
    git

    ## TUI
    iamb # matrix
    btop
    feh # iamge viewer
    lf # file browser

    ## Nix
    nixfmt
    nixd

    ## Rust
    jetbrains.rust-rover
    rustup

    ## Games
    (prismlauncher.override {
      jdks = [
        jdk21
      ];
    })

    zsh
    jdk21
    pinentry-tty # TODO: setup
  ];

  programs.steam.enable = true;

  ##### GPG Agent #####
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
