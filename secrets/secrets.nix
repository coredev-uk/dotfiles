let
  # Users
  paul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7";

  # Systems
  hyperion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICL9+Cp3dUkcgvzGUaDcfsoywXeaRISJNZ/Tgqqzlk6k";
in
{
  "hyperion.age".publicKeys = [
    hyperion
    paul
  ];
  "proton_username.age".publicKeys = [
    paul
  ];
  "proton_password.age".publicKeys = [
    paul
  ];

}
