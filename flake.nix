{
  description = "Kybe's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-vesktop.url = "github:nixos/nixpkgs/pull/476347/head";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        knx = nixpkgs.lib.nixosSystem {
	  inherit system;

	  specialArgs = {
	    inherit inputs system;
	  };

	  modules = [
	    ./hosts/knx
	  ];
	};
      };
    };
}
