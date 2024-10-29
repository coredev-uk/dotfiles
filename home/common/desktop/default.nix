{ desktop, ... }:

{
  imports = [
    (./. + "/${desktop}")

    ./hyprland # Experimental

    ./app
    ./eww
  ];

}
