{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnumake
    gcc

    # Node.js development
    nodejs
    bun
    pnpm
    yarn
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
      ]
    ))

    # Shell tooling
    shellcheck
    shfmt
  ];
}
