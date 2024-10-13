{ hostname, ... }:
let
  # Conditionally set the agent if the hostname is poseidon (macOS) or atlas (Linux)
  onePassAgent =
    if hostname == "poseidon" then
      "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "~/.1password/agent.sock";
in
{
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
    extraConfig = ''
      Host *
          IdentityAgent ${onePassAgent}
    '';
  };
}
