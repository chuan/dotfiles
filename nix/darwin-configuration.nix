{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  programs.zsh.enable = true;
  programs.zsh.promptInit = "";

  environment.systemPackages = with pkgs; [
    bat
    fd
    htop
    nmap
    ripgrep
    tmux
    tree
    jq
    silver-searcher
    emacs28NativeComp
    alacritty
    stow
    xcpretty
    graphviz
    hunspell
  ];
  
  # Hide the dock automatically
  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 20;
      KeyRepeat = 10;
    };
    dock = {
      autohide = true;
      orientation = "bottom";
    };
  };
}
