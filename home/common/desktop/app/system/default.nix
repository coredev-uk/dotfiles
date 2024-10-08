{ desktop, ... }:
{
  imports = [
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
  ] ++ (if desktop == "i3" then [ ./polkit.nix ] else [ ]);
}
