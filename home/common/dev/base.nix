{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # C++ tooling
    clang
    gnumake
    # gcc
    xorg.libX11.dev
    xorg.libXft

    # Node.js development
    nodejs
    bun
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn
    fnm

    # Electron
    dpkg
    fakeroot
    rpm
    libglibutil

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

    # Uni project tooling
    cmake
    ninja

    # Shell tooling
    shellcheck
    shfmt
    # binutils
  ];
}
