{ desktop, ... }:

{
  imports = [
    (./. + "/${desktop}")

    ./app
  ];

}
