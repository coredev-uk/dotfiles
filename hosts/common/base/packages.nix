{ pkgs, ... }:
{
  basePackages = with pkgs; [
    bat
    binutils
    curl
    chromium
    eza
    file
    git
    jq
    killall
    nfs-utils
    ntfs3g
    pciutils
    polkit
    polkit_gnome
    ripgrep
    rsync
    sbctl
    tpm2-tss
    tree
    unzip
    usbutils
    vim
    wget
  ];
}
