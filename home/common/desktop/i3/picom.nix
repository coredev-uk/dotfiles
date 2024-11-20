{ pkgs, ... }:

{
  home.packages = with pkgs; [
    picom
  ];

  # ref: https://mynixos.com/nixpkgs/options/services.picom
  services.picom = {
    enable = true;
    # config = ''
    #   # picom config
    # '';
  };
}
