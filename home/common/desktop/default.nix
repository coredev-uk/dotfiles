{
  pkgs,
  meta,
  self,
  ...
}:
{

  age.secrets.proton_username.file = "${self}/secrets/proton_username.age";
  age.secrets.proton_password.file = "${self}/secrets/proton_password.age";

  imports = [
    (./. + "/${meta.desktop}")

    # Environment Configurations
    ./default/gtk.nix
    ./default/qt.nix
    ./default/xdg.nix

    ../scripts

    # Standard Programs
    ../programs/gaming.nix
    ../programs/zen.nix
    # ./programs/rclone.nix
  ];

  home.packages = with pkgs; [
    brave
    catppuccin-gtk
    cider
    desktop-file-utils
    discord
    file-roller
    # jellyfin-media-player
    loupe
    mpv
    nautilus
    proton-pass
    papers
    spotify
    thunderbird
  ];

}
