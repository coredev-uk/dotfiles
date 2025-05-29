{ pkgs, ... }:

let
  # Define the content of your ~/.ssh/config within Home Manager
  sshConfigContent = pkgs.lib.strings.concatLines [
    "# SSH Config File managed by NixOS Home Manager"
    ""
    "# 1. My Home Servers (using private key ~/.ssh/id_home)"
    "Host 10.147.20.*"
    "    User sysadmin"
    "    IdentityFile ~/.ssh/id_home"
    "    IdentitiesOnly yes"
    ""
    "# 2. My University Server (using private key ~/.ssh/id_ukc)"
    "Host *.kent.ac.uk"
    "    User pt357"
    "    IdentityFile ~/.ssh/id_ukc"
    "    IdentitiesOnly yes"
    ""
    "# 3. The Arch User Repository (using private key ~/.ssh/id_aur)"
    "Host aur.archlinux.org"
    "    User aur"
    "    IdentityFile ~/.ssh/id_aur"
    "    IdentitiesOnly yes"
    ""
    "# 4. My GitHub Key (using private key ~/.ssh/id_github)"
    "Host github.com-personal"
    "    HostName github.com"
    "    User git"
    "    IdentityFile ~/.ssh/id_github"
    "    IdentitiesOnly yes"
  ];

  fullKnownHostsContent = pkgs.lib.strings.concatLines [
    "# GitHub"
    "github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7"
    ""
    "# AUR"
    "aur.archlinux.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPtuX2qOFQUxuH9wR/ZavxkjCherF9sKQJb1yYML21i"
    ""
    "# Home Servers"
    "10.147.20.18 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv"
    "10.147.20.20 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv"
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
    extraConfig = sshConfigContent;

    userKnownHostsFile = "~/.ssh/common_hosts ~/.ssh/known_hosts";

    forwardAgent = true;
    addKeysToAgent = "yes";
  };

}
