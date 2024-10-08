rec {
  colours = rec {
    inherit (catppuccin-macchiato)
      pink
      red
      yellow
      green
      ;
    inherit (catppuccin-macchiato) subtext0 subtext1 text;
    inherit (catppuccin-macchiato) overlay0 overlay1 overlay2;
    inherit (catppuccin-macchiato) surface0 surface1 surface2;

    accent = darkBlue;
    black = catppuccin-macchiato.crust;
    white = catppuccin-macchiato.rosewater;
    lightPink = catppuccin-macchiato.flamingo;
    lightRed = catppuccin-macchiato.maroon;
    orange = catppuccin-macchiato.peach;
    cyan = catppuccin-macchiato.teal;
    blue = catppuccin-macchiato.sapphire;
    darkBlue = catppuccin-macchiato.blue;
    lightBlue = catppuccin-macchiato.sky;
    purple = catppuccin-macchiato.mauve;
    lightPurple = catppuccin-macchiato.lavender;
    bg = catppuccin-macchiato.base;
    bgDark = catppuccin-macchiato.mantle;

    old = rec {
      foreground = "#ffffff";
      background = "#00000000";
      module = "#1e1e2e";
      black = "#000000";
      caffeine = "#89dceb";
      datetime = "#fab387";
      volume = "#89b4fa";
      updates = "#f5c2e7";
      language = "#f38ba8";
      vpn = "#a6e3a1";
      microphone = "#cba6f7";
      nowplaying = "#f38ba8";
    };
  };

  catppuccin-macchiato = {
    rosewater = "#f4dbd6";
    flamingo = "#f0c6c6";
    pink = "#f5bde6";
    mauve = "#c6a0f6";
    red = "#ed8796";
    maroon = "#ee99a0";
    peach = "#f5a97f";
    yellow = "#eed49f";
    green = "#a6da95";
    teal = "#8bd5ca";
    sky = "#91d7e3";
    sapphire = "#7dc4e4";
    blue = "#8aadf4";
    lavender = "#b7bdf8";

    subtext0 = "#a5adcb";
    subtext1 = "#b8c0e0";
    text = "#cad3f5";

    overlay0 = "#6e738d";
    overlay1 = "#8087a2";
    overlay2 = "#939ab7";

    surface0 = "#363a4f";
    surface1 = "#494d64";
    surface2 = "#5b6078";

    base = "#24273a";
    crust = "#181926";
    mantle = "#1e2030";
  };
}
