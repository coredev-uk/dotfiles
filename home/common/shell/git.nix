{ pkgs, ... }:
{
  home.file.".config/git/allowed_signers".text = ''
    core@coredev.uk ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7
    paul@coredev.uk ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7
  '';

  home.packages = with pkgs; [ gh ];

  programs.git = {
    enable = true;

    includes = [
      {
        condition = "hasconfig:remote.*.url:git@github.com:*/**";
        contents.user.email = "core@coredev.uk";
        contents.user.name = "Core";
      }
    ];

    settings = {
      user = {
        email = "paul@coredev-uk";
        name = "Paul Thompson";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQpQFDxvGq+x6sHldr81kFtftS6KFEzbOtoRKKTXFR7";
      };

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      branch.sort = "-committerdate";
      pull.rebase = false;
      init.defaultBranch = "main";
      commit.gpgSign = true;
      tag.gpgSign = true;

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.config/git/allowed_signers";
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
