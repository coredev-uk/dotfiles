{ pkgs, ... }:

let
    i3-background = pkgs.writeShellScriptBin "i3-background" ''
        directory=~/.wallpapers
        random_background=$(ls $directory/* | shuf -n 1)
        rm ~/.current-wallpaper.png
        ln -s $random_background ~/.current-wallpaper.png
        DISPLAY=:0.0 feh --bg-fill $random_background
    '';
in
{
    home.packages = with pkgs; [
        feh
        i3-background
    ];
}