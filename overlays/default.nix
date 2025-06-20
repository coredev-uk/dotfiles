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

      cargoHash = "sha256-alvn+d7XTYrw8KXw+k+++J3CsBwAUbQQlh24/EOEzwY=";

      cargoPatches = [
        (prev.fetchpatch {
          name = "fix-sigsegv-on-x86_64-unknown-linux-gnu-targets";
          url = "https://github.com/denoland/deno/commit/400a9565c335b51d78c8909f4dbf1dbd4fb5e5d8.patch";
          hash = "sha256-dTIw7P6sB6Esf+lSe/gc3cX54GkzLWF5X55yxP/QYoo=";
          includes = [ "cli/Cargo.toml" ];
        })
      ];

      postPatch =
        oldAttrs.postPatch
        +
          prev.lib.optionalString
            (
              prev.stdenv.hostPlatform.isLinux
              || (prev.stdenv.hostPlatform.isDarwin && prev.stdenv.hostPlatform.isx86_64)
            )
            ''
              # LTO crashes with the latest Rust + LLVM combination.
              # https://github.com/rust-lang/rust/issues/141737
              # TODO: remove this once LLVM is upgraded to 20.1.7
              ${prev.yq}/bin/tomlq -ti '.profile.release.lto = false' Cargo.toml
            '';

      checkFlags = oldAttrs.checkFlags ++ [
        # Use of VSOCK, might not be available on all platforms
        "--skip=js_unit_tests::serve_test"
        "--skip=js_unit_tests::fetch_test"
      ];
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [
        (_final: _prev: {
          # example = prev.example.overrideAttrs (oldAttrs: rec {
          # ...
          # });

        })
      ];
    };
  };
}
