{ pkgs, ... }:
{
  basePackages = with pkgs; [
    _1password
    bat
    binutils
    curl
    eza
    file
    git
    jq
    killall
    nfs-utils
    ntfs3g
    pciutils
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