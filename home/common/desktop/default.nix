{ pkgs, desktop, ... }:

{
  imports = [
    (./. + "/${desktop}")

    ../app
  ];
}