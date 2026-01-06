{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../modules
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  firefox.enable = true;
  hyprland.enable = true;

  networking.hostName = "knx";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.sharedModules = [
    inputs.nixvim.homeModules.nixvim
  ];

  home-manager.users.kybe = import ../../home/home.nix;

  system.stateVersion = "25.11";
}
