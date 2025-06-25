let
  paul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv";
  users = [
    paul
  ];

  hyperion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICL9+Cp3dUkcgvzGUaDcfsoywXeaRISJNZ/Tgqqzlk6k";
  systems = [
    hyperion
  ];
in
{
  "k3s.age".publicKeys = users ++ systems;
}
