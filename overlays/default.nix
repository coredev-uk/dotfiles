{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # Removed once https://github.com/NixOS/nixpkgs/pull/416177 is in nixos-unstable
    deno = prev.deno.overrideAttrs (oldAttrs: {
      version = "2.3.6";
      src = prev.fetchFromGitHub {
        owner = "denoland";
        repo = "deno";
        rev = "v2.3.6";
        hash = "sha256-l3cWnv2cEmoeecYj38eMIlgqlRjDbtQuc6Q3DmOJoqE=";
      };
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [
        (_final: prev: {
          # example = prev.example.overrideAttrs (oldAttrs: rec {
          # ...
          # });

          deno = prev.deno.overrideAttrs (oldAttrs: {
            version = "2.3.6";
            src = prev.fetchFromGitHub {
              owner = "denoland";
              repo = "deno";
              rev = "v2.3.6";
              hash = "sha256-l3cWnv2cEmoeecYj38eMIlgqlRjDbtQuc6Q3DmOJoqE=";
            };
          });

        })
      ];
    };
  };
}
