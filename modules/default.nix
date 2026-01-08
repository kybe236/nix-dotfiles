{ ... }:
{
  imports = [
    ./wireguard.nix
    ./hyprland.nix
    ./programs.nix
    ./firefox.nix
    ./system.nix
    ./zsh.nix
  ];
}
