{ pkgs, ... }:
{
  basePackages = with pkgs; [
    _1password-cli
    agenix
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
