{
  lib,
  stdenv,
  fetchFromGitHub,
  httplib,
  openssl,
  nlohmann_json,
  curl,
  cmake,
  zlib,
  makeWrapper,
}:
let
  olderNixpkgsCommit = "7d30c40939dc11b8e93407cdb94c13f4d21d771a";
  olderNixpkgsSha256 = "1ynka6gclb0nwm10d3w749q76r03ydli488jb7c306gf0rrgxsl4";

  pkgsFromOlderNixpkgs =
    import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/${olderNixpkgsCommit}.tar.gz";
        sha256 = olderNixpkgsSha256;
      })
      {
        system = "x86_64-linux";
        config = { };
        overlays = [ ];
      };

  oldCertBundleFile = "${pkgsFromOlderNixpkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
in
stdenv.mkDerivation rec {
  pname = "beammp-launcher";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "BeamMP";
    repo = "BeamMP-Launcher";
    rev = "v${version}";
    hash = "sha256-9ScsctCuhRL8XiLKYxLrKpb6rj2tsPUXqs9eN2mcTIQ=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    makeWrapper
  ];

  buildInputs = [
    zlib
    httplib
    nlohmann_json
    openssl
    curl
  ];

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
  enableParallelBuilding = true;

  installPhase = ''
    runHook preInstall
    install -D -m0755 BeamMP-Launcher $out/bin/BeamMP-Launcher

    wrapProgram $out/bin/BeamMP-Launcher \
      --set SSL_CERT_FILE "${oldCertBundleFile}"

    echo ""
    echo "--- BeamMP Launcher Setup Hint ---"
    echo "  For BeamNG.drive to work correctly with Proton, you might need to create a symlink."
    echo ""
    echo "  The Launcher expects BeamNG.drive's 'AppData/Local' folder at: $HOME/.local/share/BeamNG.Drive"
    echo ""
    echo "  If your Steam library is at '~/.local/share/Steam', the source path would typically be:"
    echo "    ~/.local/share/Steam/steamapps/compatdata/284160/pfx/drive_c/users/steamuser/AppData/Local/BeamNG.drive"
    echo ""
    echo "  Example command to create the symlink (adjust source path if needed):"
    echo "    ln -s ~/.local/share/Steam/steamapps/compatdata/284160/pfx/drive_c/users/steamuser/AppData/Local/BeamNG.drive $HOME/.local/share/BeamNG.Drive"
    echo ""
    echo "----------------------------------"

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/BeamMP/BeamMP-Launcher";
    description = "Official BeamMP Launcher";
    # license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ JManch ];
    mainProgram = "BeamMP-Launcher";
  };
}
