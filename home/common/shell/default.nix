{
  pkgs,
  self,
  lib,
  type,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  imports =
    [
      ./bat.nix
      ./bottom.nix
      ./git.nix
      ./fastfetch.nix
      ./starship.nix
      ./nh.nix
      ./ssh.nix
      ./zsh.nix
    ]
    ++ (lib.optional (type == "desktop") ./ghostty.nix)
    ++ (lib.optional (type == "desktop") ./xdg.nix);

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
  };

  home.packages = with pkgs; [
    devenv
    direnv
    self.packages.${pkgs.stdenv.system}.neovim
    age
    btop
    termscp
  ];

  catppuccin.btop.enable = true;
}
