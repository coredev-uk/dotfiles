{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    gcc

    # Node.js development
    nodejs
    nodePackages_latest.prettier
    nodePackages_latest.typescript
    pnpm
    yarn
    bun
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