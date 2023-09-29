{ config, lib, pkgs, inputs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.etc."nix/nix.conf".knownSha256Hashes = ["1771492abe652ae9f4a6d978908620ef06176b6609c968a388bac5f2e43d68c1"];
  environment.systemPackages =
    [ pkgs.vim
    ];
  system.checks.verifyNixChannels = false;
  security.pam.enableSudoTouchIdAuth = true;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Set Git commit hash for darwin-version.

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
