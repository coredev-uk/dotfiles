{ pkgs, ... }:

let 
    electron-env = pkgs.writeShellScriptBin "electron-env" ''
      export LD_LIBRARY_PATH=$(for pkg in glib.out nss nspr dbus.lib atk cups.lib libdrm.out gtk3 cairo pango.out xorg.libX11 xorg.libXcomposite xorg.libXdamage xorg.libXext xorg.libXfixes xorg.libXrandr xorg.libxcb mesa expat libxkbcommon alsa-lib libGL; do nix build --print-out-paths --no-link nixpkgs#$pkg; done | awk '{print $1"/lib"}' | tr '\n' ':' | sed 's/:$//')
    '';
in
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

    # Electron
    electron-env
    dpkg
    fakeroot
    rpm
    libglibutil

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