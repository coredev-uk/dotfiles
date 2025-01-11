{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnumake
    gcc

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
    juce

    # Shell tooling
    shellcheck
    shfmt
  ];
}
