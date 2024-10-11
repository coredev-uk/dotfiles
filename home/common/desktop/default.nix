{ desktop, ... }:

{
  imports = [
    (./. + "/${desktop}")

    ./app
    ./eww
  ];

}
