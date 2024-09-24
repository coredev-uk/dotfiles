{ pkgs, ... }:
{
  # TODO: Add backup key
  home.file.".config/git/allowed_signers".text = ''
    core@coredev.uk sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPF/JcM0mZ9qCfNYrAnaA/rS+N4FuQo+rGxzqAOURIktAAAACnNzaDpHaXRIdWI= YK5C-1
    core@coredev.uk ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7 1Password

    core@cider.sh sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPF/JcM0mZ9qCfNYrAnaA/rS+N4FuQo+rGxzqAOURIktAAAACnNzaDpHaXRIdWI= YK5C-1
    core@cider.sh ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7 1Password

    pt357@kent.ac.uk sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPF/JcM0mZ9qCfNYrAnaA/rS+N4FuQo+rGxzqAOURIktAAAACnNzaDpHaXRIdWI= YK5C-1
    pt357@kent.ac.uk ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7 1Password
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
        push = {
          default = "matching";
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