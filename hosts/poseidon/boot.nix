{
  pkgs,
  lib,
  meta,
  ...
}:
{
  system.stateVersion = lib.mkForce 6;

  users.users.${meta.username} = {
    name = meta.username;
    home = lib.mkForce "/Users/${meta.username}";
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv"
    ];

    packages = [ pkgs.home-manager ];
  };
}
