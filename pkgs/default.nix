# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{
  pkgs ? (import ../nixpkgs.nix) { },
}:
{
  # example = pkgs.callPackage ./example { };
  # neovim = pkgs.callPackage ./nvim { };
  nixfmt-plus = pkgs.callPackage ./nixfmt-plus.nix { };
  cider = pkgs.callPackage ./cider.nix { };
}
