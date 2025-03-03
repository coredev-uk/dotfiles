{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      catppuccin.catppuccin-vsc
    ];
  };
}
