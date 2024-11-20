{
  pkgs,
  hostname ? "",
  ...
}:
let
  inherit ((import ./colours.nix)) colours;
  libx = import ./lib.nix { inherit (pkgs) lib; };
in
rec {
  inherit (libx) hexToRgb;
  inherit colours;

  catppuccin = {
    flavor = "mocha";
    accent = "blue";
    size = "standard";
  };

  # src: https://unsplash.com/photos/brown-rocky-mountain-under-white-clouds-during-daytime-jdpJqWO9Sx8 (https://unsplash.com/collections/220388/macos-desktop-wallpapers)
  wallpaper = ./wallpapers/mountain.jpg;

  wallpaperDir = "~/pictures/wallpaper";

  gtkTheme = {
    name = "catppuccin-mocha-blue-standard";
    package = pkgs.catppuccin-gtk.override {
      inherit (catppuccin) size;
      variant = catppuccin.flavor;
      accents = [ catppuccin.accent ];
    };
  };

  qtTheme = {
    name = "Catppuccin-Mocha-Blue";
    package = pkgs.catppuccin-kvantum.override {
      variant = catppuccin.flavor;
      accent = catppuccin.accent;
    };
  };

  iconTheme = rec {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
    iconPath = "${package}/share/icons/${name}";
  };

  cursorTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  fonts = {
    default = {
      name = "Inter";
      package = pkgs.inter;
      size = "11";
    };
    iconFont = {
      name = "Font Awesome";
      package = pkgs.font-awesome;
    };
    monospace = {
      name = "Fira Code";
      package = pkgs.fira-code;
    };
    emoji = {
      name = "Joypixels";
      package = pkgs.joypixels;
    };
  };
}
