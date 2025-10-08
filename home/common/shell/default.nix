{
  pkgs,
  self,
  lib,
  meta,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  imports = [
    ./bat.nix
    ./bottom.nix
    ./fastfetch.nix
    ./starship.nix
    ./nh.nix
    ./ssh.nix
    ./zsh.nix
  ]
  ++ lib.optional (!meta.isHeadless) ./git.nix
  ++ lib.optionals meta.isDesktop [
    ./ghostty.nix
    ./xdg.nix
  ];

  catppuccin = {
    inherit (theme.catppuccin) flavor;
    inherit (theme.catppuccin) accent;
  };

  programs = {
    eza.enable = true;
    git.enable = true;
    home-manager.enable = true;
    jq.enable = true;
    lazygit = {
      enable = true;
      settings.promptToReturnFromSubprocess = false;
    };
    opencode.enable = true;

  };

  home.packages = with pkgs; [
    at
    devenv
    direnv
    self.packages.${pkgs.stdenv.system}.neovim
    age
    btop
    termscp
  ];

  catppuccin.btop.enable = true;
}
