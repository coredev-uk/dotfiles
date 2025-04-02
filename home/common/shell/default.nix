{
  pkgs,
  self,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  imports = [
    ./bat.nix
    ./bottom.nix
    ./ghostty.nix
    ./git.nix
    ./fastfetch.nix
    ./starship.nix
    ./xdg.nix
    ./zsh.nix
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
  };

  home.packages = with pkgs; [
    self.packages.${pkgs.stdenv.system}.neovim
    age
    btop
    termscp
  ];

  catppuccin.btop.enable = true;
}
