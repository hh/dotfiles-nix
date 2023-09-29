{ config, lib, pkgs, inputs, ... }:

{ # look ant man home-configuration.nix for options
  # https://nix-community.github.io/home-manager/options.html
  # programs.zsh.initExtraFirst = ''
  #   set -x
  #   set -euo pipefail
  #   # echo HELLO
  # '';
  # programs.zsh.initExtra = ''
  #   set +x
  #   set +euo pipefail
  # '';
  # programs.zsh.oh-my-zsh.enable = true;
  # home.username = "hh";
  imports = [ inputs.nix-doom-emacs.hmModule ] ;
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = "${inputs.ii-doom-config}";
    # extraPackages = epkgs: [ epkgs.ii-pair ];
    emacsPackagesOverlay = self: super: {
      sql = null;
      ii-pair = null;
      # ii-pair = self.trivialBuild {
      #   pname = "ii-pair";
      #   version = "1";
      #   packageRequires = [ self.s ];
      #   src = pkgs.fetchFromGitHub {
      #     owner = "humacs";
      #     repo = "ii-pair";
      #     rev = "f7d2283901b5a9ad62c4fcfa2792cc3fbd8d0f53";
      #     sha256 = "sha256-tEIiadsAR8StTrOsWUUWx3RhJ9OZFpbXo/NBCwUjtKA=";
      #   };
      # };
    };
    #  org-roam = super.org-roam.overrideAttrs (esuper: {
    #    src = pkgs.fetchFromGitHub {
    #      owner = "org-roam";
    #      repo = "org-roam";
    #      rev = "e9ae19c01cb1fac8256e404b3f9c06f4be5468e6";
    #      sha256 = "4U75arstVrPA9mXNd6c4Jmjn1uEgFXPk7DhZo08v9Dg=";
    #    };
    #  });};
  };
  programs.zsh.enable = true;
  home.homeDirectory = lib.mkForce "/Users/hh";
  home.stateVersion = "23.05";
  home.sessionPath = [
    "$HOME/.config/emacs/bin"
    "$HOME/.config/doom/bin"
    "/opt/homebrew/opt/gnu-getopt/bin"
  ];
}
