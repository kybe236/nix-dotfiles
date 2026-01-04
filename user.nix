{ pkgs, ... }:
{
  users.users.kybe = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
}