{
  autoPatchelfHook,
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
  libnotify,
  libpulseaudio,
  libGL,
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
}:

let
  pname = "Cider";
  version = "2.0.3";
  description = "A cross-platform Apple Music experience built on Vue.js and written from the ground up with performance in mind.";
  homepage = "https://cider.sh";
  downloadPage = "https://cidercollective.itch.io/cider";
in

stdenv.mkDerivation rec {
  inherit pname version;

  src = requireFile rec {
    name = "Cider.deb";
    url = "https://cidercollective.itch.io/cider";
    # sha256sum /nix/store/m2ada8dfgnh0kz9jvpqsn60mfg3n1mp3-Cider.deb
    sha256 = "0xj3a6vzw9lv9w78yf2vkdgh2wwg6azbpjfd8cvb038cknm5gd6f";
  };

  meta = with lib; {
    inherit
      description
      homepage
      downloadPage
      ;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    # license = licenses.unfree;
    maintainers = with maintainers; [ core ];
    platforms = [ "x86_64-linux" ];
  };

  propagatedBuildInputs = [
    dbus
    libX11
  ];

  nativeBuildInputs = [
    alsa-lib
    autoPatchelfHook
    cups
    dpkg
    libdrm
    libuuid
    libX11
    libXdamage
    libXScrnSaver
    libXtst
    libxcb
    libxshmfence
    makeShellWrapper
    mesa
    nss
    wrapGAppsHook3
  ];

  dontWrapGApps = true;

  libPath = lib.makeLibraryPath [
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
    libcxx
    libdrm
    libnotify
    libpulseaudio
    libGL
    libuuid
    libX11
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXScrnSaver
    libxcb
    libXtst
    mesa
    nspr
    openssl
    nss
    pango
    stdenv.cc.cc
    systemd
    # wayland
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
    ln -s ${lib.getLib openssl}/lib/libssl.so $out/lib/cider/libssl.so.1.0.0
    ln -s ${lib.getLib openssl}/lib/libcrypto.so $out/lib/cider/libcrypto.so.1.0.0

    sed -e "s|/opt/cider|$out/bin|g" -i $out/share/applications/cider.desktop
    makeWrapper $out/lib/cider/Cider \
      $out/bin/cider \
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
  #   mimeTypes = [ "x-scheme-handler/cider" ];
  # };

}
