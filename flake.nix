{
  description = "Example Darwin system flake";

  inputs = {
    nix-straight.url = "github:nix-community/nix-straight.el/version-arg" ;
    nix-straight.flake = false;
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.inputs.nix-straight.follows = "nix-straight";
    ii-doom-config.url = "github:ii/doom-config/iinix";
    ii-doom-config.flake = false;
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs, ... }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#m1
    darwinConfigurations."m1" = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.hh.imports = [
            ./home.nix
          ];
          # home-manager.users.hh = import ./home.nix;
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }

      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."m1".pkgs;
  };
}
