{pkgs, ...}: {
  programs.eww = {
    enable = true;

    configDir = ./config;
    enableZshIntegration = true;
    package = pkgs.eww;
  };

  home.packages = with pkgs; [
    eww
    ffmpeg

    # Needed for scripts
    jq
    socat
  ];

  systemd.user.services.eww = {
    Unit = {
      Description = "ElKowars wacky widgets daemon";
      PartOf = ["graphical-session.target"];
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
      Restart = "on-failure";
    };
  };
}
