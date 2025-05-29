{ desktop, lib, ... }:
{
  imports = [
    ./base.nix
    ./ssh.nix
  ] ++ lib.optional (builtins.isString desktop) ./gui.nix;
}
