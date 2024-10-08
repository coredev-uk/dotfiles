{
  autoPatchelfHook,
  makeDesktopItem,
  lib,
  requireFile,
  stdenv,
  wrapGAppsHook3,
  makeShellWrapper,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  dpkg,
  expat,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  gtk3,
  libcxx,
  libdrm,
  libglvnd,
  libnotify,
  libpulseaudio,
  libuuid,
  libX11,
  libXScrnSaver,
  libXcomposite,
  libXcursor,
  libXdamage,
  libXext,
  libXfixes,
  libXi,
  libXrandr,
  libXrender,
  libXtst,
  libxcb,
  libxshmfence,
  mesa,
  nspr,
  nss,
  openssl,
  pango,
  systemd,
  libappindicator-gtk3,
  libdbusmenu,
  libunity,
  wayland,
}:

let
  pname = "Cider";
  version = "1.0.0";
  description = "A cross-platform Apple Music experience built on Vue.js and written from the ground up with performance in mind.";
  homepage = "https://cider.sh";
  downloadPage = "https://cidercollective.itch.io/cider";
  binaryName = "cider-linux-x64";
  desktopName = "Cider";
in

stdenv.mkDerivation rec {
  inherit pname version;

  src = requireFile rec {
    name = "cider-linux-x64_1.0.0_amd64.deb";
    url = "https://cidercollective.itch.io/cider";
    # sha256sum /nix/store/9787v3r38sbbmbkxqkx9szk5snmzmf8k-cider-linux-x64_1.0.0_amd64.deb
    sha256 = "0vnrpx0lk0c9rcd209vmq0armxi62dz3wfnja8ma95b526w8rd39";
  };

  meta = with lib; {
    inherit
      description
      homepage
      downloadPage
      binaryName
      ;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    # license = licenses.unfree;
    maintainers = with maintainers; [ core ];
    platforms = [ "x86_64-linux" ];
  };

  nativeBuildInputs = [
    alsa-lib
    autoPatchelfHook
    cups
    dpkg
    libdrm
    libuuid
    libXdamage
    libX11
    libXScrnSaver
    libXtst
    libxcb
    libxshmfence
    mesa
    nss
    wrapGAppsHook3
    makeShellWrapper
  ];

  dontWrapGApps = true;

  libPath = lib.makeLibraryPath [
    libcxx
    systemd
    libpulseaudio
    libdrm
    mesa
    stdenv.cc.cc
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libglvnd
    libnotify
    libX11
    libXcomposite
    libunity
    libuuid
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXtst
    nspr
    libxcb
    openssl
    pango
    libXScrnSaver
    libappindicator-gtk3
    libdbusmenu
    wayland
  ];

  unpackPhase = ''
    dpkg-deb --fsys-tarfile ${src} | \
      tar -x --no-same-owner
    mv usr $out
  '';

  # Will be adjusted in future versions
  installPhase = ''
    runHook preInstall

    # Now it requires lib{ssl,crypto}.so.1.0.0. Fix based on Spotify pkg.
    # https://github.com/NixOS/nixpkgs/blob/efea022d6fe0da84aa6613d4ddeafb80de713457/pkgs/applications/audio/spotify/default.nix#L129
    mkdir -p $out/lib/cider
    ln -s ${lib.getLib openssl}/lib/libssl.so $out/lib/cider-linux-x64/libssl.so.1.0.0
    ln -s ${lib.getLib openssl}/lib/libcrypto.so $out/lib/cider-linux-x64/libcrypto.so.1.0.0

    sed -e "s|/opt/cider-linux-x64|$out/bin|g" -i $out/share/applications/cider-linux-x64.desktop
    makeWrapper $out/lib/cider-linux-x64/Cider \
      $out/bin/cider-linux-x64 \
      --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}/" \
      --prefix LD_LIBRARY_PATH : ${libPath}

    runHook postInstall
  '';

  # desktopItem = makeDesktopItem {
  #   name = pname;
  #   exec = binaryName;
  #   icon = pname;
  #   inherit desktopName;
  #   genericName = description;
  #   categories = [
  #     "Audio"
  #     "AudioVideo"
  #   ];
  #   mimeTypes = [ "x-scheme-handler/discord" ];
  # };

}
