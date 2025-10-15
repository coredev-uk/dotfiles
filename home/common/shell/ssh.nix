{ pkgs, meta, ... }:

let
  # Define the content of your ~/.ssh/config within Home Manager
  sshConfigContent = pkgs.lib.strings.concatLines [
    "# SSH Config File managed by NixOS Home Manager"
    ""
    "# 1. My Home Servers (using private key ~/.ssh/id_home)"
    "Host 192.168.20.10"
    "    User paul"
    "    IdentityFile ~/.ssh/id_home"
    "    IdentitiesOnly yes"
    ""
    "# 2. The Arch User Repository (using private key ~/.ssh/id_aur)"
    "Host aur.archlinux.org"
    "    User aur"
    "    IdentityFile ~/.ssh/id_aur"
    "    IdentitiesOnly yes"
    ""
    "# 3. GitHub Configuration (using private key ~/.ssh/id_github)"
    "Host github.com"
    "  HostName github.com"
    "  User git"
    "  IdentityFile ~/.ssh/id_github"
    "  IdentitiesOnly yes"
    ""
    "# 4. BitBucket Configuration (using private key ~/.ssh/id_bitbucket)"
    "Host bitbucket.org"
    " HostName bitbucket.org"
    " User git"
    " IdentityFile ~/.ssh/id_bitbucket"
    " IdentitiesOnly yes"
    ""
  ];

  fullKnownHostsContent = pkgs.lib.strings.concatLines [
    "# SSH Known Hosts File managed by NixOS Home Manager"
    "# GitHub"
    "github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl"
    ""
    "# BitBucket"
    "bitbucket.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIazEu89wgQZ4bqs3d63QSMzYVa0MuJ2e2gKTKqu+UUO"
    ""
    "# AUR"
    "aur.archlinux.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPtuX2qOFQUxuH9wR/ZavxkjCherF9sKQJb1yYML21i"
    ""
    "# Home Servers"
    "192.168.20.10 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICL9+Cp3dUkcgvzGUaDcfsoywXeaRISJNZ/Tgqqzlk6k"
  ];
in
{
  home.file.".ssh/common_hosts" = {
    text = fullKnownHostsContent;
    recursive = true;
  };

  # Enable the SSH program for your user
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    extraConfig = sshConfigContent;

    matchBlocks."*" = {
      userKnownHostsFile = "~/.ssh/common_hosts ~/.ssh/known_hosts";
      forwardAgent = true;
      addKeysToAgent = "yes";
    };
  };

  # Agenix Identity
  age.identityPaths = [ "/home/${meta.username}/.ssh/id_github" ];

}
