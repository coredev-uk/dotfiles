{ pkgs, lib, ... }:
{
  home.file.".config/git/allowed_signers".text = ''
    core@coredev.uk ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqvK5C-1 1Password
    core@cider.sh ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv 1Password
    pt357@kent.ac.uk ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHp9jtjj8GUHYoLQa+PzfOOkJ9ODPc4G3YlZfYXQFqv 1Password
  '';

  home.packages = with pkgs; [ gh ];

  programs = {
    git = {
      enable = true;

      userEmail = "core@coredev.uk";
      userName = "Core";

      includes = [
        {
          condition = "hasconfig:remote.*.url:*github.com*ciderapp/**";
          contents.user.email = "core@cider.sh";
        }
        {
          condition = "hasconfig:remote.*.url:git@git.cs.kent.ac.uk:*/**";
          contents.user.email = "pt357@kent.ac.uk";
          contents.user.name = "Paul Thompson";
        }
      ];

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      extraConfig = {
        branch = {
          sort = "-committerdate";
        };
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
        gpg = {
          format = "ssh";
          ssh = {
            defaultKeyCommand = "sh -c 'echo key::$(ssh-add -L | head -n1)'";
            allowedSignersFile = "~/.config/git/allowed_signers";
            program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          };
        };
        commit = {
          gpgSign = true;
        };
        tag = {
          gpgSign = true;
        };
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com";
          };
        };
      };
    };
  };
}
