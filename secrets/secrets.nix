let
  paul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv";
  users = [
    paul
  ];

  hyperion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZ6Fqa7aM2UDtFxzRk7He/cSc0pWgXzBbgAokM8Rbsd";
  systems = [
    hyperion
  ];
in
{
  "k3s.age".publicKeys = users ++ systems;
}
