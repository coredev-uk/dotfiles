{
  desktop,
  username,
  pkgs,
  self,
  inputs,
  ...
}: let
  theme = import "${self}/lib/theme" {inherit pkgs;};
in {
  imports = [
    (./. + "/${desktop}.nix")

    ../hardware/yubikey.nix
    ../services/pipewire.nix
    ./qt.nix
  ];

  # Enable Plymouth and surpress some logs by default.
  boot.plymouth.enable = true;
  boot.kernelParams = [
    # The 'splash' arg is included by the plymouth option
    "quiet"
    "loglevel=3"
    "rd.udev.log_priority=3"
    "vt.global_cursor_default=0"
  ];

  hardware.graphics.enable = true;

  # Enable location services
  location.provider = "geoclue2";

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".beta
  ];

  programs._1password = {
    enable = true;
    package = pkgs.unstable._1password-cli;
  };

  programs._1password-gui = {
    package = pkgs.unstable._1password-gui-beta;
    enable = true;
    polkitPolicyOwners = ["${username}"];
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    polkit-1.u2fAuth = true;
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
        zen-bin
        zen
      '';
      mode = "0755";
    };
  };

  fonts = {
    packages = with pkgs; [
      liberation_ttf
      ubuntu_font_family

      # Compatibility Fonts
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans

      theme.fonts.default.package
      theme.fonts.emoji.package
      theme.fonts.iconFont.package
      theme.fonts.monospace.package
    ];

    # Use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [
          "${theme.fonts.default.name}"
          "${theme.fonts.emoji.name}"
        ];
        sansSerif = [
          "${theme.fonts.default.name}"
          "${theme.fonts.emoji.name}"
        ];
        monospace = ["${theme.fonts.monospace.name}"];
        emoji = ["${theme.fonts.emoji.name}"];
      };
    };
  };
}
