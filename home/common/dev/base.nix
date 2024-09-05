{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    gcc

    nodejs
    nodePackages_latest.prettier
    corepack-nodejs
    fnm

    # Nix tooling
    deadnix
    nil
    nix-init
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