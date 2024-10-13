_: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  programs.ssh = {
    startAgent = true;
    extraConfig = {
      "Host *" = {
        IdentityAgent = "~/.1password/agent.sock";
      };
    };
  };
}
