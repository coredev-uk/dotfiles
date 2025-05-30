{ pkgs, lib, ... }:
{
  home.file.".config/git/allowed_signers".text = ''
    core@coredev.uk ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7 
    pt357@kent.ac.uk ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFiZJO5uLLRe4XhtxRbafK69xzOUCAKhbtq7f+CqrfSI
  '';

  home.packages = with pkgs; [ gh ];

  programs.git = {
    enable = true;

    userEmail = "core@coredev.uk";
    userName = "Core";

    includes = [
      {
        condition = "hasconfig:remote.*.url:git@git.cs.kent.ac.uk:*/**";
        contents.user.email = "pt357@kent.ac.uk";
        contents.user.name = "Paul Thompson";
      }
    ];

    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };

    # Incredibly stupid, I don't know why they changed this, its stupid
    iniContent.gpg.format = lib.mkForce "ssh";

    extraConfig = {
      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7";
      };
      branch = {
        sort = "-committerdate";
      };
      pull = {
        rebase = false;
      };
      init = {
        defaultBranch = "main";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.config/git/allowed_signers";
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

    ignores = [
      ".vscode"
      ".npm"
      ".cache"
      ".icons"
      ".mozilla"
      ".local"
      ".electron-gyp"
      ".idea"
      ".lock"
      ".DS_Store"

      # Application Development
      "node_modules"
      "dist"
      "yarn-error.log"
      ".yarnclean"

      # Stuff
      "doc/tags"
      "*.vim-flavor"
      "*.swp"
      "*.bundle"
      "vendor"
    ];
  };
}
