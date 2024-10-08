let
  users = [ "paul" ];
in
{
  "hyperion.age".publicKey = users ++ [ "sysadmin" ];
}
