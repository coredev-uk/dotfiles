{ inputs, ... }:
let
    lib = inputs.nixpkgs.lib;
in
{
    config.system = {
        isDesktop = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Indicates whether the system should be configured as a desktop.";
        };
    };
}