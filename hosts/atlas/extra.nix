{ self, ... }:
{
  imports = [ "${self}/hosts/common/services/networkmanager.nix" ];
}