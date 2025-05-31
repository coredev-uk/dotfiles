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
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPF/JcM0mZ9qCfNYrAnaA/rS+N4FuQo+rGxzqAOURIktAAAACnNzaDpHaXRIdWI= YK5C-1"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIK+uHvJa0C6nT7WIm4XYyCIrJv5NOL6c55lu9TtNzQyzAAAABHNzaDo= YK5C-2"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7"
    ];

    packages = [ pkgs.home-manager ];
  };
}
