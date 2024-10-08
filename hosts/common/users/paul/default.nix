{ pkgs, config, ... }:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  user = "paul";
in
{
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "audio"
        "networkmanager"
        "users"
        "video"
        "wheel"
      ]
      ++ ifExists [
        "docker"
        "plugdev"
        "render"
        "lxd"
      ];

    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPF/JcM0mZ9qCfNYrAnaA/rS+N4FuQo+rGxzqAOURIktAAAACnNzaDpHaXRIdWI= YK5C-1"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIK+uHvJa0C6nT7WIm4XYyCIrJv5NOL6c55lu9TtNzQyzAAAABHNzaDo= YK5C-2"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7 1Password"
    ];

    packages = [ pkgs.home-manager ];
  };

  # This is a workaround for not seemingly being able to set $EDITOR in home-manager
  environment.sessionVariables = {
    EDITOR = "vim";
  };

  # Passwordless sudo (not very security compliant but cba atm fyi ty)
  security.sudo.extraRules = [{
    users = ["${user}"];
    commands = [{ 
      command = "ALL";
      options = ["NOPASSWD"];
    }];
  }];
}