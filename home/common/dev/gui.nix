{ pkgs, ... }:
{
  programs.vscode = {
    enable = false;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      catppuccin.catppuccin-vsc
    ];
  };
}
