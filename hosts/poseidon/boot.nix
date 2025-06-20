{
  pkgs,
  username,
  lib,
  ...
}:
{
  system.stateVersion = lib.mkForce 6;

  users.users.${username} = {
    name = username;
    home = lib.mkForce "/Users/${username}";
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv"
    ];

    packages = [ pkgs.home-manager ];
  };
}
