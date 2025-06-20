{
  pkgs,
  desktop,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      # C++ tooling
      clang
      gnumake

      # Node.js development
      nodejs
      bun
      nodePackages.npm
      nodePackages.pnpm
      nodePackages.yarn
      fnm

      # Nix tooling
      deadnix
      nil
      nix-init
      # Wrapper
      nixfmt-plus
      nixfmt-rfc-style
      nurl
      statix

      # Python tooling
      (pkgs.python3.withPackages (
        p: with p; [
          virtualenv
          pyserial
          distutils
        ]
      ))

      # Shell tooling
      shellcheck
      shfmt
      # binutils
    ]
    ++ lib.optional (builtins.isString desktop) [
      # Tauri
      webkitgtk_4_1
      pkg-config
      openssl

      # Electron
      dpkg
      fakeroot
      rpm
      libglibutil
    ];
}
