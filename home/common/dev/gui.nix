{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      catppuccin.catppuccin-vsc
    ];
  };

  home.packages = with pkgs; [
    zed-editor

    # uni
    jetbrains.clion
    juce

  ];

}
