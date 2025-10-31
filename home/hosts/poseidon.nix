{ lib, ... }:
{

  imports = [
    ../common/programs/discord.nix
    ../common/programs/ghostty.nix # NixOS/nixpkgs#388984
    ../common/programs/zen.nix
  ];

  programs.ghostty.enable = lib.mkForce false;
}
