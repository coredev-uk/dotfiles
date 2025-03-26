# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  pkgs ? (import ../nixpkgs.nix) {},
  inputs ? {},
}: {
  # example = pkgs.callPackage ./example { };
  # neovim = pkgs.callPackage ./nvim { inherit nvf; };
  nixfmt-plus = pkgs.callPackage ./nixfmt-plus.nix {};
  cider = pkgs.callPackage ./cider.nix {};

  neovim =
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvim.nix];
    })
    .neovim;
}
