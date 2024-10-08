{
  lib,
  stdenv,
  requireFile,
  dpkg,
  wrapGAppsHook,
  autoPatchelfHook,
  alsa-lib,
  atk,
  at-spi2-atk,
  at-spi2-core,
  cairo,
  cups,
  dbus,
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
  libuuid,
  libX11,
  libxcb,
  libXcomposite,
  libXcursor,
  libXdamage,
  libXext,
  libXfixes,
  libXi,
  libXrandr,
  libXrender,
  libXScrnSaver,
  libXtst,
  mesa,
  nspr,
  nss,
  openssl,
  pango,
  systemd,
}:

stdenv.mkDerivation rec {

  pname = "cider";
  version = "1.0.0";

  src = requireFile rec {
    name = "cider-linux-x64_1.0.0_amd64.deb";
    url = "https://cidercollective.itch.io/cider";
    # sha256sum /nix/store/i57n6n2jlkika258hiwyljyivsmyb8c9-cider-linux-x64_1.0.0_amd64.deb
    sha256 = "16pj97lwn79d7vami645pwk7bjvivjx3jy5cr24g44xwv9g9wzmx";
  };

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
  ];

  # Some might not be necessary - Chromium requried libs
  buildInputs = [
    libcxx
    systemd
    libpulseaudio
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
    libdrm
    libnotify
    libuuid
    libX11
    libxcb
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXScrnSaver
    libXtst
    mesa
    nspr
    nss
    pango
    systemd
  ];

  libPath = lib.makeLibraryPath buildInputs;

  dontWrapGApps = true;

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

  meta = with lib; {
    description = "some stupid description that i cba to write";
    homepage = "https://cider.sh";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ core ];
  };

}
