{
  pkgs,
  meta,
  config,
  ...
}:
{

  programs.rclone = {
    enable = true;
    package = pkgs.rclone;

    remotes = {
      protonDrive = {
        config = {
          type = "protondrive";
          "2fa" = "637654";
        };
        secrets = {
          username = config.age.secrets.proton_username.path;
          password = config.age.secrets.proton_password.path;
        };
        mounts = {
          "/" = {
            enable = true;
            mountPoint = "/home/${meta.username}/protondrive";
          };
        };
      };

    };
  };
}
