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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv"
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