{ pkgs, ... }:
let
  user = "sysadmin";
in
{
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "networkmanager"
      "users"
      "video"
      "wheel"
    ];
    linger = true;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv"
    ];

    packages = [ pkgs.home-manager ];
  };

  # This is a workaround for not seemingly being able to set $EDITOR in home-manager
  environment.sessionVariables = {
    EDITOR = "vim";
  };

}
