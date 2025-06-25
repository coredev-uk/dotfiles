let
  paul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv";
  users = [
    paul
  ];

  hyperion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKCmA4pOckYwJCeDUMOrRCU5xX2g1x9Ddsf3eDa4UViX";
  systems = [
    hyperion
  ];
in
{
  "k3s.age".publicKeys = users ++ systems;
}
