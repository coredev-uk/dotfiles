{ lib, meta, ... }:
{
  imports = [
    ./base.nix
  ] ++ lib.optional (meta.isDesktop) ./gui.nix;
}
